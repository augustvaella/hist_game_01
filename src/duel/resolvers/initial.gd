class_name InitialDuelResolver extends DuelResolver

func resolve(state: StageState):
	next_resolver(state, "field set")
