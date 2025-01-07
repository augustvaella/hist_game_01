class_name FriendHandSelectDuelResolver extends DuelResolver

const REGISTER_KEY_CARD: String = "friend hand select"
const REGISTER_KEY_CHALLENGER: String = "friend challenger"

func resolve(state: StageState):
	state.stage.hand.show_hand()

	if state.register[REGISTER_KEY_CARD]:
		return

	state.stage.hand.check_initial()

	var current_chara = state.stage.friend.next_current_item()

	if not current_chara:
		state.stage.hand.hide_hand()
		next_resolver(state, "FoeTurn")
		return

	state.register[REGISTER_KEY_CHALLENGER] = current_chara


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_hand()
	elif event.is_action_pressed("Right"):
		state.check_right_hand()
	elif event.is_action_pressed("Accept"):
		select_opponent(state)


func select_opponent(state: DuelState):
	var c = state.get_checked_hand() # DuelCard
	state.register[REGISTER_KEY_CARD] = c

	match c.element.opponent_select:
		Card.OpponentSelect.NONE:
			state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend challenge"]))
		Card.OpponentSelect.ENEMY_SINGLE:
			state.stage.foe.mode_single()
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEnemySingleEvent.new()
			state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["enemy select"]))
		Card.OpponentSelect.ENEMY_ALL:
			state.stage.foe.mode_all()
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEnemyAllEvent.new()
			state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["enemy select"]))
		Card.OpponentSelect.FRIEND_SINGLE:
			state.stage.friend.mode_single()
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectFriendSingleEvent.new()
			state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend select"]))
		Card.OpponentSelect.FRIEND_ALL:
			state.stage.friend.mode_all()
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectFriendAllEvent.new()
			state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend select"]))
	state.stage.hand.hide_hand()
