class_name ResourceServer extends Node

signal requested_load_resource(resource_path: String, error: Error)
signal loading_resource(resource_path: String, progress: Array)
signal loaded_resource(resource: Resource)
signal failed_load_resource(resource_path: String)
signal invalid_resource(resource_path: String)

var _resources: Dictionary # <resource_id:int, resource:Resource>
var _resource_name_table: Dictionary # <resource_name: String, resource_id: int>
var _resource_path_table: Dictionary # <resource_path: String, resource_id: int>

var _loading_path_table: LoadingPathTable
var _is_process: bool

@export var count_per_process: int

func _ready():
	_resources = {}
	_resource_name_table = {}
	_resource_path_table = {}
	_loading_path_table = LoadingPathTable.new()
	_is_process = false

func load_resource(resource_path: String):
	var res = load(resource_path)
	if res:
		_on_load_resource(res)
	else:
		failed_load_resource.emit(resource_path)


func _on_load_resource(resource: Resource):
	var id = resource.get_instance_id()
	if _resources.has(id):
		Log.log_warn("[ResourceServer] the loaded Resource %s(%s) already exists in ResourceServer." % [resource.resource_name, resource.resource_path])
	_resource_path_table[resource.resource_path] = id
	if not resource.resource_name.is_empty:
		_resource_name_table[resource.resource_name] = id
	_resources[id] = resource
	_loading_path_table.remove(resource.resource_path)
	Log.log_debug("[ResourceServer] loaded Resource#%d %s(%s)" % [id, resource.resource_name, resource.resource_path])
	loaded_resource.emit(resource)


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
			_on_load_resource(res)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			Log.log_error("[ResourceServer] failed load Resource %s" % [resource_path])
			_loading_path_table.remove(resource_path)
			failed_load_resource.emit(resource_path)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			Log.log_trace("[ResourceServer] loading %s %d" % [resource_path, progress[0]])
			loading_resource.emit(resource_path, progress)
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE:
			Log.log_error("[ResourceServer] invalid Resource %s" % [resource_path])
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
			return
		_on_load_process(path)


func get_resource(resource_string: String) -> Resource:
	var id = _resource_name_table.get(resource_string)
	if id:
		return _resources[id]
	id = _resource_path_table.get(resource_string)
	if id:
		return _resources[id]
	Log.log_error("[ResourceServer] failed get Resource %s" % [resource_string])
	return null


func get_resource_id(resource_id: int) -> Resource:
	var r = _resources.get(resource_id)
	if r:
		return r
	Log.log_error("[ResourceServer] failed get Resource #%d" % [resource_id])
	return null
	

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
		if _table.size() == 0:
			return String()
		if _index >= _table.size():
			_index = 0
		return _table[_index]
