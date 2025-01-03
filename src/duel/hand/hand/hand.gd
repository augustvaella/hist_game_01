class_name DuelCardHand extends Control

@export var container: Container

func set_state(state: DuelState):
	await get_tree().create_timer(0.05).timeout


func add_card(state: DuelState, card: DuelCard):
	state.add_card_to_hand(card.get_card())
	container.add_child(card)
