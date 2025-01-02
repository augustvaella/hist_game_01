class_name ResourceServer extends Node

signal requested_load_resource(resource_path: String, error: Error)
signal loading_resource(resource_path: String, progress: Array)
signal loaded_resource(resource: Resource)
signal failed_load_resource(resource_path: String)
signal invalid_resource(resource_path: String)

@export var loader: ResourceServerLoader
@export var saver: ResourceServerSaver

func _ready():
	loader.requested_load_resource.connect(\
		func(resource_path: String, error: Error): \
			requested_load_resource.emit(resource_path, error))
	loader.loading_resource.connect(\
		func(resource_path: String, progress: Array): \
			loading_resource.emit(resource_path, progress))
	loader.loaded_resource.connect(\
		func(resource: Resource): \
			loaded_resource.emit(resource))
	loader.failed_load_resource.connect(\
		func(resource_path: String): \
			failed_load_resource.emit(resource_path))
	loader.invalid_resource.connect(\
		func(resource_path: String): \
			invalid_resource.emit(resource_path))

func load_resource(resource_path: String):
	loader.load_resource(resource_path)


func has_resource_id(resource_id: int) -> bool:
	return loader.has_resource_id(resource_id)


func has_resource(resource_name: String) -> bool:
	return loader.has_resource(resource_name)


func request_load_resource(resource_set_path: String):
	loader.request_load_resource(resource_set_path)


func get_resource(resource_name: String) -> Resource:
	return loader.get_resource(resource_name)


func get_resource_from_id(resource_id: int) -> Resource:
	return loader.get_resource_from_id(resource_id)


func get_packed_scenes(packed_scene_array: Array):
	loader.get_packed_scenes(packed_scene_array)


func get_all_resources(resource_array: Array):
	loader.get_all_resources(resource_array)
