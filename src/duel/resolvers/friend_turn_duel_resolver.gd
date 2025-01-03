class_name FriendTurnDuelResolver extends DuelResolver

func resolve(state: StageState):
	state.begin_friend_turn()


func on_input(event: InputEvent):
	if event.is_action_pressed("Accept"):
		pass
