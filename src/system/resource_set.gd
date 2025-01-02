class_name ResourceSet extends Resource

@export var childs: Array[Resource]

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


func remove_resource(resource_name: String):
	var arr = childs.filter(func(resource): resource.resource_name == resource_name)
	for r in arr:
		childs.erase(r)
		

func _to_string() -> String:
	return "ResourceSet#%d %s" % [get_instance_id(), super.to_string()]
