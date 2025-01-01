class_name Startup extends Node2D

var _stages: Dictionary # <String, Stage>

func _ready():
	# load GameResourceSet
	# Master.resource_server.load(game_resource_set_path)
	_stages = {}

	# startup
	##await ready_stage("res://src/duel/duel.tscn", Cn.STAGE_DUEL)


func ready_stage(path: String, stage_name: String):
	pass
	#_stages[stage_name] = await load_stage(path)
	#await _stages[stage_name].ready()


func load_stage(path: String) -> Stage:
	return null
	#Master.resource_server.request_load_resource(path)
	#var resource = await Master.resource_server.loaded_resource
	#return resource.instantiate() as Stage


func append_stage(stage_name: String, stage: Stage):
	_stages[stage_name] = stage


func change_stage(stage_name: String):
	#if not _stages.has(stage_name):
	#	Log.log_error("[Startup] hasn't appended such Stage named %s" % [stage_name])
	#	return
	#var stage_to_finish = get_current_stage()
	#stage_to_finish.finish()
	#await stage_to_finish.finished
	#remove_child(stage_to_finish)
	#var stage_to_start = _stages[stage_name]
	#add_child(stage_to_start)
	#stage_to_start.start()
	#await stage_to_start.started
	pass


func get_current_stage() -> Stage:
	return get_child(0)
