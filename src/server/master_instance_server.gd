class_name MasterInstanceServer extends InstanceServer

@export var master_resource_server: ResourceServer

func instantiate_packed_scenes():
	var master_resources = []
	master_resource_server.get_all_resources(master_resources)
	for r in master_resources:
		if r is PackedScene:
			var rn = r.resource_name if not r.resource_name.is_empty() else r.resource_path
			add_packed_scene(r, rn)
