class_name ChallengeDuelResolver extends DuelResolver
## deals Card Challenge
##
## one challenger / one or more opponents
##


const REGISTER_KEY_TYPE: String = "characters selected" # DuelOpponentSelectEvent
const REGISTER_KEY_IS_FRIEND_TURN: String = "challenge is friend turn"

func resolve(state: StageState):
	var card = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD]
	var challenger = state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CHALLENGER]
	var opponents = state.register[REGISTER_KEY_TYPE]

	state.stage.discard.discard(state, card)
	for op in opponents:
		if not challenger.element or not op.element:
			return

		if challenge(state, card.element, challenger.element, op.element):
			return
	
	await state.stage.get_tree().create_timer(0.5).timeout
	
	state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD] = null
	
	next_resolver(state, "friend hand select")


func on_input(state: StageState, event: InputEvent):
	pass

func challenge(state: StageState, card: Card, challenger: Element, opponent: Element):
	card.try_challenge(state, challenger, opponent)

	if state.is_all_friend_or_foe_dead(opponent):
		next_resolver(state, "Result")

	if state.is_all_friend_or_foe_dead(challenger):
		next_resolver(state, "Result")
	
	return false
