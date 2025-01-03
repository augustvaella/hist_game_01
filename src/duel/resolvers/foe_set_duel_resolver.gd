class_name FoeSetDuelResolver extends DuelResolver

func resolve(state: StageState):
	await state.set_foe()

	state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["friend draw hand"]))
