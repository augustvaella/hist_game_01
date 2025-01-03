class_name FriendDrawHandDuelResolver extends DuelResolver

func resolve(state: StageState):
	for i in range(state.hand.get_diff_count_default()):
		state.friend_hand_draw()
	state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["friend hand select"]))


func on_input(state: StageState, event: InputEvent):
	pass
