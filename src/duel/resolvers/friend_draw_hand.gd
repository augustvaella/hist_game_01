class_name FriendDrawHandDuelResolver extends DuelResolver

func resolve(state: StageState):
	for i in range(state.hand.get_diff_count_default()):
		state.stage.deck.draw(state)
	state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD] = null
	state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["friend hand select"]))


func on_input(state: StageState, event: InputEvent):
	pass
