class_name FriendHandSelectDuelResolver extends DuelResolver

const REGISTER_KEY_CARD: String = "friend hand select"

func resolve(state: StageState):
	pass

func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_hand()
	elif event.is_action_pressed("Right"):
		state.check_right_hand()
	elif event.is_action_pressed("Accept"):
		select_opponent(state, state.get_checked_hand())


func select_opponent(state: DuelState, card: DuelCard):
	state.register[REGISTER_KEY_CARD] = card
	match card.opponent_select:
		Card.OpponentSelect.NONE:
			state.duel_listened_event_emit(DuelNextResolverEvent.new(state.resolvers["friend challenge"]))
		Card.OpponentSelect.ENEMY_SINGLE:
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.EnemySingle.new()
			state.duel_listened_event_emit(DuelNextResolverEvent.new(state.resolvers["enemy select"]))
		Card.OpponentSelect.ENEMY_ALL:
			state.register[EnemySelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.EnemyAll.new()
			state.duel_listened_event_emit(DuelNextResolverEvent.new(state.resolvers["enemy select"]))
		Card.OpponentSelect.FRIEND_SINGLE:
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.FriendSingle.new()
			state.duel_listened_event_emit(DuelNextResolverEvent.new(state.resolvers["friend select"]))
		Card.OpponentSelect.FRIEND_ALL:
			state.register[FriendSelectDuelResolver.REGISTER_KEY_TYPE] = DuelOpponentSelectEvent.FriendAll.new()
			state.duel_listened_event_emit(DuelNextResolverEvent.new(state.resolvers["friend select"]))
