class_name FriendSetDuelResolver extends DuelResolver

func resolve(state: StageState):
	await state.set_friend()
	await state.set_deck()
	await state.set_discard()
	await state.set_hand()

	state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["FoeSet"]))
