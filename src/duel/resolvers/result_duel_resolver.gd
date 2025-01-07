class_name ResultDuelResolver extends DuelResolver

func resolve(state: StageState):
	Log.log_info("Result: %s" % [state.result])
