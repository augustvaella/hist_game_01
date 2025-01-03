class_name FriendTurnDuelResolver extends DuelResolver

func resolve(state: DuelState):
	state.begin_friend_turn()

	# next_resolver.emit(state.get_duel().resolvers["FoeTurn"])
