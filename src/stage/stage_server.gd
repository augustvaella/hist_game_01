class_name StageServer extends InstanceServer

signal finished_instantiate_stages

@export var instantiate_interval: float = 0.1

func instantiate_stages():
	var arr = []
	Master.instance_server.get_all_instances(arr)
	for r in arr:
		if r is Stage:
			var path = r.scene_file_path
			var n = path.get_basename().get_file()
			var p = Master.master_resource_server.get_resource(path)
			add_packed_scene(p, n)
			await get_tree().create_timer(instantiate_interval).timeout
	
	finished_instantiate_stages.emit()
