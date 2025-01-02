class_name Startup extends Node2D

const MASTER_RESOURCE_SET_PATH:String = "res://test/assets/test_resource_set_1.tres"

func _ready():
	Master.master_resource_server.loading_resource.connect(Loading.reflesh_load_status)
	Master.user_resource_server.loading_resource.connect(Loading.reflesh_load_status)

	Master.master_resource_server.request_load_resource(MASTER_RESOURCE_SET_PATH)


func ready_stage(path: String, stage_name: String):
	pass


func load_stage(path: String) -> Stage:
	return null


func change_stage(stage_name: String):
	pass


func get_current_stage() -> Stage:
	return get_child(0)
