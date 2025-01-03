class_name FoeSetDuelResolver extends DuelResolver

func resolve(state: StageState):
	await state.set_foe()

	state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["FriendTurn"]))
