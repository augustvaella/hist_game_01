class_name ChallengeDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "characters selected" # DuelOpponentSelectEvent
const REGISTER_KEY_IS_FRIEND_TURN: String = "challenge is friend turn"

func resolve(state: StageState):
	var card = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD]
	var challenger = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CHALLENGER]
	var opponents = state.register[REGISTER_KEY_TYPE]

	state.stage.discard.discard(state, card)
	opponents.map(func(op): card.card.try_challenge(state, challenger.character, op.character))
	await state.stage.get_tree().create_timer(0.5).timeout
	next_resolver(state, "friend hand select")


func on_input(state: StageState, event: InputEvent):
	pass
