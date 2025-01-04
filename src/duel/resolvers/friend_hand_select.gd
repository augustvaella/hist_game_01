class_name FriendHandSelectDuelResolver extends DuelResolver

const REGISTER_KEY_CARD: String = "friend hand select"
const REGISTER_KEY_CHALLENGER: String = "friend challenger"

func resolve(state: StageState):
	state.register[REGISTER_KEY_CHALLENGER] = state.stage.friend.characters[0]

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
	match c.card.opponent_select:
		Card.OpponentSelect.NONE:
			state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["friend challenge"]))
		Card.OpponentSelect.ENEMY_SINGLE:
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.EnemySingle.new()
			state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["enemy select"]))
		Card.OpponentSelect.ENEMY_ALL:
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.EnemyAll.new()
			state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["enemy select"]))
		Card.OpponentSelect.FRIEND_SINGLE:
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.FriendSingle.new()
			state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["friend select"]))
		Card.OpponentSelect.FRIEND_ALL:
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.FriendAll.new()
			state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers["friend select"]))
