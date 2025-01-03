class_name FoeSetDuelResolver extends DuelResolver

func resolve(state: DuelState):
	await state.set_foe()

	next_resolver.emit(state.get_duel().resolvers["FriendTurn"])
