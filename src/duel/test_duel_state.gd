class_name TestDuelState extends DuelState
@export var next_stage_state: StageState

func get_next_stage_state() -> StageState:
	return next_stage_state
