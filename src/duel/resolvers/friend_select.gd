class_name FriendSelectDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "friend select" # DuelOpponentSelectEvent

func resolve(state: StageState):
	pass
	# state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["friend hand select"]))


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_actor()
	elif event.is_action_pressed("Right"):
		state.check_right_actor()
	elif event.is_action_pressed("Accept"):
		pass
		#select_opponent(state, state.get_checked_hand())


func select_opponent(state: DuelState, actor: Actor):
	pass
