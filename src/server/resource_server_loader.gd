class_name ResourceServerLoader extends Node

const DEFAULT_COUNT_PER_PROCESS: int = 5

signal requested_load_resource(resource_path: String, error: Error)
signal loading_resource(resource_path: String, progress: Array)
signal loaded_resource(resource: ResourceSet)
signal failed_load_resource(resource_path: String)
signal invalid_resource(resource_path: String)

signal cleared_all_requested_load

var _resources: Array[Resource]
var _resource_name_table: Dictionary # Dictionary<String, int>
var _resource_id_table: Dictionary # Dictionary<int, int>

var _loading_path_table: LoadingPathTable
var _is_process: bool

@export var count_per_process: int

func _ready():
	_resources = []
	_resource_name_table = {}
	_resource_id_table = {}
	_loading_path_table = LoadingPathTable.new()
	_is_process = false

	if count_per_process <= 0:
		count_per_process = DEFAULT_COUNT_PER_PROCESS


func load_resource(resource_path: String):
	var res = load(resource_path)
		
	if res:
		_on_load_resource(res)
	else:
		failed_load_resource.emit(resource_path)


func has_resource(resource_name: String) -> bool:
	return _resources.any(func(resource): resource.resource_name == resource_name)


func has_resource_id(resource_id: int) -> bool:
	return _resources.any(func(resource): resource.get_instance_id() == resource_id)


func _on_load_resource(resource: Resource):
	if resource is ResourceSet:
		var res: Array[Resource] = []
		resource.get_all_resources(res)
		for r in res:
			add_resource(r)
	else:
		add_resource(resource)
	loaded_resource.emit(resource)
	Log.log_debug("[ResourceServerLoader] loaded Resource#%d %s(%s)" \
		% [resource.get_instance_id(), resource.resource_name, resource.resource_path])


func add_resource(resource: Resource):
	if not resource:
		Log.log_error("[ResourceServerLoader] Resource to add is null")
		return

	var id = resource.get_instance_id()
	var rn = resource.resource_name if not resource.resource_name.is_empty() else resource.resource_path
	if has_resource_id(id):
		Log.log_warn(\
			"[ResourceServerLoader] the loaded Resource %s(%s) already exists in ResourceServer." \
			% [resource.resource_name, resource.resource_path])
		return
	_resources.append(resource)
	var index = _resources.size() - 1
	_resource_id_table[id] = index
	_resource_name_table[rn] = index
	Log.log_debug("[ResourceServerLoader] added Resource#%d %s(%s)" \
		% [id, resource.resource_name, resource.resource_path])


func remove_resource(resource_name: String):
	if _resource_name_table.has(resource_name):
		var index = _resource_name_table[resource_name]
		var id = _resources[index].get_instance_id()
		var path = _resources[index].resource_path
		_resource_name_table.erase(resource_name)
		_resource_id_table.erase(id)
		_resources[index] = null
		Log.log_debug("[ResourceServerLoader] removed Resource#%d %s(%s)" \
			% [id, resource_name, path])


func remove_resource_id(resource_id: int):
	if _resource_id_table.has(resource_id):
		var index = _resource_id_table[resource_id]
		var nm = _resources[index].resource_name
		var path = _resources[index].resource_path
		_resource_name_table.erase(nm)
		_resource_id_table.erase(resource_id)
		_resources[index] = null
		Log.log_debug("[ResourceServerLoader] removed Resource#%d %s(%s)" \
			% [resource_id, nm, path])


func free_resource(resource_name: String):
	var r = get_resource(resource_name)
	if r:
		remove_resource(resource_name)
		_free_resource(r)


func release_resource_id(resource_id: int):
	var r = get_resource_id(resource_id)
	if r:
		remove_resource_id(resource_id)
		_free_resource(r)


func _free_resource(resource: Resource):
	var id = resource.get_instance_id()
	var nm = resource.resource_name
	var path = resource.resource_path
	resource.free()
	Log.log_debug("[ResourceServerLoader] freed Resource#%d %s(%s)" \
		% [id, nm, path])


func request_load_resource(resource_path: String):
	var error = ResourceLoader.load_threaded_request(resource_path)
	if error == Error.OK:
		_loading_path_table.append(resource_path)
		_is_process = true
	requested_load_resource.emit(resource_path, error)


func _on_load_process(resource_path: String):
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(resource_path, progress)
	match status:
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			var res = ResourceLoader.load_threaded_get(resource_path)
			_loading_path_table.remove(resource_path)
			_on_load_resource(res)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			Log.log_error("[ResourceServerLoader] failed load Resource %s" \
				% [resource_path])
			_loading_path_table.remove(resource_path)
			failed_load_resource.emit(resource_path)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			Log.log_trace("[ResourceServerLoader] loading %s %d" \
				% [resource_path, progress[0]])
			loading_resource.emit(resource_path, progress)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE:
			Log.log_error("[ResourceServerLoader] invalid Resource %s" \
				% [resource_path])
			_loading_path_table.remove(resource_path)
			invalid_resource.emit(resource_path)


func _process(delta: float):
	if not _is_process:
		return
	_process_load()


func _process_load():
	for i in range(count_per_process):
		var path = _loading_path_table.get_next()
		if path.is_empty():
			_is_process = false
			cleared_all_requested_load.emit()
			return
		_on_load_process(path)


func get_resource(resource_name: String) -> Resource:
	if _resource_name_table.has(resource_name):
		return _resources[_resource_name_table[resource_name]]
	Log.log_error("[ResourceServerLoader] failed get Resource %s" \
		% [resource_name])
	return null


func get_resource_id(resource_id: int) -> Resource:
	if _resource_id_table.has(resource_id):
		return _resources[_resource_id_table[resource_id]]
	Log.log_error("[ResourceServerLoader] failed get Resource #%d" % [resource_id])
	return null


func get_all_resources(resource_array: Array):
	resource_array.assign(_resources)


class LoadingPathTable extends RefCounted:
	var _table: PackedStringArray
	var _index = 0
		
	func _init():
		_table = []
		_index = 0
	
	func append(path: String):
		if path.is_empty():
			return
		_table.append(path)
	
	func remove(path: String):
		var ind = _table.find(path)
		_table.remove_at(ind)

	func get_next() -> String:
		_index += 1
		if is_empty():
			return String()
		if _index >= _table.size():
			_index = 0
		return _table[_index]

	func is_empty() -> bool:
		return _table.size() == 0
