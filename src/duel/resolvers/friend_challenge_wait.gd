class_name FriendChallengeWaitDuelResolver extends DuelResolver

const REGISTER_KEY_TYPE: String = "characters selected" # DuelOpponentSelectEvent
const REGISTER_KEY_IS_FRIEND_TURN: String = "challenge is friend turn"

func resolver(state: StageState):
	var card = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD]
	var challenger = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CHALLENGER]
	var opponents = state.register[REGISTER_KEY_TYPE]

	var op = opponents.pop_front()
	if op:
		if not challenger.element or not op.element:
			state.register[ChallengeDuelResolver.REGISTER_KEY_CHALLENGE] = card.element.challenge
			state.register[ChallengeDuelResolver.REGISTER_KEY_CHALLENGER] = challenger.element
			state.register[ChallengeDuelResolver.REGISTER_KEY_OPPONENT] = op.element
			state.register[ChallengeDuelResolver.REGISTER_KEY_NEXT_RESOLVER] = "friend challenge wait"
			next_resolver(state, "challenge")
			return
		next_resolver(state, "friend challenge wait")
		return

	state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD] = null
	await state.stage.get_tree().create_timer(0.5).timeout
	next_resolver(state, "friend hand select")
