class_name FriendSetDuelResolver extends DuelResolver

func resolve(state: DuelState):
	await state.set_friend()
	await state.set_hand()

	next_resolver.emit(state.get_duel().resolvers["FoeSet"])
