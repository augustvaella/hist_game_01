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
	opponents.map(func(op): challenge(state, card.card, challenger.element, op.element))
	
	await state.stage.get_tree().create_timer(0.5).timeout
	
	state.register[FriendHandSelectDuelResolver.REGISTER_KEY_CARD] = null
	
	next_resolver(state, "friend hand select")


func on_input(state: StageState, event: InputEvent):
	pass

func challenge(state: StageState, card: Card, challenger: Element, opponent: Element):
	card.try_challenge(state, challenger, opponent)

	if not opponent.is_vital():
		opponent.kill(state)

	if not challenger.is_vital():
		challenger.kill(state)
