class_name ResourceSet extends Resource
## Resource collector to be loaded comfortably
## ResourceSet is not stored on ResourceServer.

@export var childs: Array[Resource]

func is_empty() -> bool:
	return childs.is_empty()


func get_all_resources(resources: Array[Resource]):
	for c in childs:
		if c is ResourceSet:
			c.get_all_resources(resources)
		else:
			resources.push_back(c)


func set_resource(resource: Resource):
	if not resource:
		Log.log_error("[ResourceSet] Resource to add is null")
		return

	childs.append(resource)
	emit_changed()


func remove_resource(resource_string: String):
	var arr = childs.filter(func(resource): resource.resource_name == resource_string)
	for r in arr:
		childs.erase(r)
		emit_changed()
		

func _to_string() -> String:
	return "ResourceSet#%d %s" % [get_instance_id(), super.to_string()]
