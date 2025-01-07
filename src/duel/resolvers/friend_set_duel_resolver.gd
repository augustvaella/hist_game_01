class_name FriendSetDuelResolver extends DuelResolver

func resolve(state: StageState):
	await state.set_friend()
	await state.set_deck()
	await state.set_discard()
	await state.set_hand()

	#state.register[EvalResultDuelResolver.REGISTER_KEY_REST_TURNS] = 5

	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["FoeSet"]))
