class_name ObjectPool extends Node

var _pool: Array[Object]

func _ready():
	_pool = []


# to be overriden
func _create_object() -> Object:
	return Object.new()


func get_object() -> Object:
	if _pool.size() > 0:
		return _pool.pop_back()
	return _create_object()


func return_object(object: Object):
	_pool.push_back(object)
