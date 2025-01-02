class_name InstanceServer extends Node

signal instantiated_scenes

var _scenes: Dictionary #

func _ready():
	_scenes = {}


func initiate_packed_scenes(packed_scenes: Array[PackedScene]):
	for p in packed_scenes:
		var s = p.instantiate()
		var n = p.resource_path.get_basename().get_file()
		_scenes[n] = s
	instantiated_scenes.emit()


func get_scene(scene_name: String) -> Node:
	if _scenes.has(scene_name):
		return _scenes[scene_name] as Node
	return null
