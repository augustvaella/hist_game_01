class_name ResultDuelResolver extends DuelResolver

func resolve(state: StageState):
	Log.info(self, "Result: %s" % [state.result])
