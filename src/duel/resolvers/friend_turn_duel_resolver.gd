class_name FriendTurnDuelResolver extends DuelResolver

func resolve(state: DuelState):
	var duel = state.get_duel()
	duel.hand.draw()
	duel.hand.draw()
	duel.hand.draw()
	await get_tree().create_timer(1.0).timeout

	# next_resolver.emit(state.get_duel().resolvers["FoeTurn"])
