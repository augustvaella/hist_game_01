class_name EnemySelectDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "enemy select" # DuelOpponentSelectEvent

func resolve(state: StageState):
	match state.stage.foe.mode:
		LinkedNodeCollector.Mode.SINGLE:
			state.stage.foe.check_initial()
		LinkedNodeCollector.Mode.ALL:
			state.stage.foe.check_all()


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_enemy()
	elif event.is_action_pressed("Right"):
		state.check_right_enemy()
	elif event.is_action_pressed("Accept"):
		select_opponent(state)
	elif event.is_action_pressed("Ban"):
		cancel_select(state)

func select_opponent(state: DuelState):
	state.select_foe_enemies()
	await state.stage.get_tree().create_timer(0.5)
	state.register[ChallengeDuelResolver.REGISTER_KEY_IS_FRIEND_TURN] = true
	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["challenge"]))

func cancel_select(state: DuelState):
	state.cancel_select_all()
	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend hand select"]))
