class_name StageState extends Resource

# to be overriden
func get_stage_name() -> String:
	return String()


# to be overriden
func get_next_stage_state() -> StageState:
	return null
