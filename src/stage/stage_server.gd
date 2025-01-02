class_name StageServer extends InstanceServer

signal finished_instantiate_stages

@export var stage_paths: PackedStringArray
@export var instantiate_interval: float = 0.1

func instantiate_stages():
	for path in stage_paths:
		var n = path.get_basename().get_file()
		var p = Master.master_resource_server.get_resource(path)
		add_packed_scene(p, n)
		await get_tree().create_timer(instantiate_interval).timeout
	
	finished_instantiate_stages.emit()
