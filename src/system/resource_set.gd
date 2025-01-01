class_name ResourceSet extends Resource

@export var resources: Array[Resource]

func initialize():
	await _instantiate_scenes()


func get_resource(resource_name: String) -> Resource:
	return null


func _to_string() -> String:
	return ""


func _instantiate_scenes():
	pass
	# for
	#    await
