class_name TestDuelState extends DuelState
@export var next_stage_state: StageState

func get_next_stage_state() -> StageState:
	return next_stage_state

func eval_result() -> bool:
	# all friends dead
	if stage.friend.is_all_dead():
		result = Result.LOSE
		return true
	
	# all enemies dead
	if stage.foe.is_all_dead():
		result = Result.WIN
		return true

	# no turn remains
	
	if turn.is_reached():
		result = Result.TIME_UP
		return true
	
	return false

func _setup():
	super._setup()
