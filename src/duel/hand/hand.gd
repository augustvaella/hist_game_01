class_name DuelHand extends Node2D

@export var deck: DuelDeck
@export var hand: DuelCardHand
@export var discard: DuelDiscard

func set_state(state: DuelState):
	deck.set_state(state)
	hand.set_state(state)
	discard.set_state(state)

func draw():
	var c = deck.draw()
	if c:
		hand.add_card(c)
