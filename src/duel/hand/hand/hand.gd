class_name DuelCardHand extends Node2D

func set_state(state: DuelState):
	set_deck(state.hand)

func set_deck(deck: HandDeck):
	pass

func add_card(card: DuelCard):
	add_child(card)
