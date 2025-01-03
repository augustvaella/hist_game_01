class_name DuelHand extends Node2D


@export var deck: DuelDeck
@export var hand: DuelCardHand
@export var discard: DuelDiscard

func set_state(state: DuelState):
	await deck.set_state(state)
	await hand.set_state(state)
	await discard.set_state(state)


func draw(state: DuelState):
	var c = deck.draw(state)
	if c:
		hand.add_card(state, c)
	await get_tree().create_timer(0.1).timeout
