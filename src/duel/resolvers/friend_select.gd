class_name FriendSelectDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "friend select" # DuelOpponentSelectEvent

func resolve(state: StageState):
	pass
	# state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["friend hand select"]))


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		pass
	elif event.is_action_pressed("Right"):
		pass
	elif event.is_action_pressed("Accept"):
		select_opponent(state, state.get_checked_hand())


func select_opponent(state: DuelState, actor: Actor):
	pass
