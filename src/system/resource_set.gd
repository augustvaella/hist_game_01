class_name ResourceSet extends Resource

@export var childs: Array[Resource]

func get_all_resources(resources: Array[Resource]):
	for c in childs:
		if c is ResourceSet:
			c.get_all_resources(resources)
		else:
			resources.push_back(c)


func _to_string() -> String:
	return "ResourceSet#%d %s" % [get_instance_id(), super.to_string()]
