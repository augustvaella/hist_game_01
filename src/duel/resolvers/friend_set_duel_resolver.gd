class_name FriendSetDuelResolver extends DuelResolver

func resolve(state: StageState):
	await state.set_friend()
	await state.set_hand()

	state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["FoeSet"]))
