class_name DuelCardHand extends Control

@export var container: Container

func set_state(state: DuelState):
	set_deck(state.hand)

func set_deck(deck: HandDeck):
	pass

func add_card(card: DuelCard):
	container.add_child(card)
