class_name FriendSetDuelResolver extends DuelResolver

func resolve(state: DuelState):
	var duel = state.get_duel()
	duel.friend.set_state(state)
	await get_tree().create_timer(1.0).timeout

	duel.hand.set_state(state)
	await get_tree().create_timer(1.0).timeout

	next_resolver.emit(state.get_duel().resolvers["FoeSet"])
