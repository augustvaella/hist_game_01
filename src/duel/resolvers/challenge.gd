class_name ChallengeDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "characters selected" # DuelOpponentSelectEvent
const REGISTER_KEY_IS_FRIEND_TURN: String = "challenge is friend turn"

func resolve(state: StageState):
	var card = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD]
	var challenger = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CHALLENGER]
	var opponents = state.register[REGISTER_KEY_TYPE]
	for c in card.card.challenges:
		opponents.map(func(op): c.challenge(state, challenger.character, op.character))
	await state.stage.get_tree().create_timer(0.5).timeout
	
func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		state.check_left_enemy()
	elif event.is_action_pressed("Right"):
		state.check_right_enemy()
	elif event.is_action_pressed("Accept"):
		select_opponent(state)

func select_opponent(state: DuelState):
	state.select_friend_actors()
