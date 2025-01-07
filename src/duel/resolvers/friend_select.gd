class_name FriendSelectDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "friend select" # DuelOpponentSelectEvent

func resolve(state: StageState):
	match state.stage.friend.mode:
		CheckableNodeCollector.Mode.SINGLE:
			state.stage.friend.check_initial()
		CheckableNodeCollector.Mode.ALL:
			state.stage.friend.check_all()


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_actor()
	elif event.is_action_pressed("Right"):
		state.check_right_actor()
	elif event.is_action_pressed("Accept"):
		select_opponent(state)
	elif event.is_action_pressed("Ban"):
		cancel_select(state)


func select_opponent(state: DuelState):
	state.select_friend_actors()
	await state.stage.get_tree().create_timer(0.5)
	state.register[ChallengeDuelResolver.REGISTER_KEY_IS_FRIEND_TURN] = true
	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["challenge"]))

func cancel_select(state: DuelState):
	state.cancel_select_all()
	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend hand select"]))
