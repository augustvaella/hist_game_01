class_name Startup extends Node2D

const MASTER_RESOURCE_SET_PATH: String = "res://assets/set/master_data.tres"
const USER_RESOURCE_SET_PATH: String = "res://assets/set/user_data.tres"
const USER_RESOURCE_RESTORE_PATH: String = "user://test_user_resource.tres"
const INITIAL_STAGE_STATE_NAME: String = "test duel state"

signal changed_stage(stage: Stage)

func _ready():
	Master.master_resource_server.loading_resource.connect(Loading.reflesh_load_status)
	Master.user_resource_server.loading_resource.connect(Loading.reflesh_load_status)

	Master.master_resource_server.request_load_resource(MASTER_RESOURCE_SET_PATH)
	await Master.master_resource_server.cleared_all_requested_load

	Master.user_resource_server.request_load_resource(USER_RESOURCE_SET_PATH)
	await Master.user_resource_server.cleared_all_requested_load

	Master.stage_server.instantiate_stages()
	await Master.stage_server.finished_instantiate_stages

	Loading.hide()

	var initial_stage_state = Master.master_resource_server.get_resource(INITIAL_STAGE_STATE_NAME)
	if initial_stage_state:
		_set_stage(initial_stage_state)
	#var r = Master.master_resource_server.get_resource("test resource 0")
	#Master.master_resource_server.save_resource(r, USER_RESOURCE_RESTORE_PATH)

func _set_stage(stage_state: StageState):
	var sn = stage_state.get_stage_name()
	if not Master.stage_server.has_scene(sn):
		Log.log_error("[Startup] Scene(%s) counldn't changed." \
			% [stage_state.stage_name])
		return
	var st = Master.stage_server.get_scene(sn)
	add_child(st)
	st.proceed(stage_state)
	await st.proceeded
	changed_stage.emit(st)


func change_stage(stage_state: StageState):
	var ps = get_current_stage()
	if ps:
		ps.finish()
		await ps.finished

	_set_stage(stage_state)


func get_current_stage() -> Stage:
	if get_child_count() == 0:
		Log.log_error("[Startup] Stage doesn't exist." \
			% [])
		return null

	return get_child(0)
