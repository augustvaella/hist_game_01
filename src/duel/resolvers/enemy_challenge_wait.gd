class_name EnemyChallengeWaitDuelResolver extends DuelResolver

const REGISTER_KEY_CHALLENGER: String = "enemy challenge wait challenger"
const REGISTER_KEY_OPPONENTS: String = "enemy challenge wait opponents"

func resolver(state: StageState):
	var challenger = state.register[REGISTER_KEY_CHALLENGER]
	var opponents = state.register[REGISTER_KEY_OPPONENTS]

	var op = opponents.pop_front()
	if op:
		var challenge = op.challenge_options
		if not challenger.element or not op.element:
			state.register[ChallengeDuelResolver.REGISTER_KEY_CHALLENGE] = challenge
			state.register[ChallengeDuelResolver.REGISTER_KEY_CHALLENGER] = challenger.element
			state.register[ChallengeDuelResolver.REGISTER_KEY_OPPONENT] = op.element
			state.register[ChallengeDuelResolver.REGISTER_KEY_NEXT_RESOLVER] = "enemy challenge wait"
			next_resolver(state, "challenge")
			return
		next_resolver(state, "enemy challenge wait")
		return

	state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD] = null
	await state.stage.get_tree().create_timer(0.5).timeout
	next_resolver(state, "FoeTurn")
