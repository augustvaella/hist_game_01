class_name InstanceServer extends Node

var _scenes: Dictionary # Dictionary<String, Node>

func _ready():
	_scenes = {}


func has_scene(scene_name: String) -> bool:
	return _scenes.has(scene_name)


func copy_scene(scene_name: String) -> Node:
	var c = get_scene(scene_name)
	if c:
		return c.duplicate()
	return null


func get_scene(scene_name: String) -> Node:
	if _scenes.has(scene_name):
		return _scenes[scene_name] as Node
	Log.log_error("[InstanceServer] Scene(%s) doesn't exist in the server." \
		% [scene_name])
	return null


func add_scene(scene: Node, scene_name: String):
	if _scenes.has(scene):
		Log.log_error("[InstanceServer] Scene#%d(%s) already exists in the server." \
			% [scene.get_instance_id(), scene_name])
		return

	_scenes[scene_name] = scene
	Log.log_debug("[InstanceServer] added Scene#%d(%s)" \
		% [scene.get_instance_id(), scene_name])

func add_packed_scene(packed_scene: PackedScene, scene_name: String):
	if not packed_scene:
		Log.log_error("[InstanceServer] PackedScene is null." \
		% [])
		return

	var p = packed_scene.instantiate()
	_scenes[scene_name] = p
	Log.log_debug("[InstanceServer] instantiated and added Scene#%d %s(%s)" \
		% [p.get_instance_id(), scene_name, packed_scene.resource_path])


func remove_scene(scene_name: String):
	if _scenes.has(scene_name):
		var s = _scenes[scene_name]
		var id = s.get_instance_id()
		_scenes.erase(scene_name)
		Log.log_debug("[InstanceServer] removed Scene#%d %s" \
			% [id, scene_name])


func free_scene(scene_name: String):
	if _scenes.has(scene_name):
		var s = _scenes[scene_name]
		remove_scene(scene_name)
		var id = s.get_instance_id()
		s.free()
		Log.log_debug("[InstanceServer] freed Scene#%d %s" \
			% [id, scene_name])


func get_packed_scene(scene_name: String) -> PackedScene:
	var p = PackedScene.new()
	var s = get_scene(scene_name)
	if s:
		var err = p.pack(s)
		if err == Error.OK:
			return s
	Log.log_error("[InstanceServer] Scene(%s) couldn't packed" \
		% [scene_name])
	return null


func get_all_instances(instance_array: Array):
	instance_array.assign(_scenes.values())
