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


func get_current_checked_hand() -> DuelCard:
	return hand.get_current_checked()


func get_all_checked_hand(array: Array):
	hand.get_checked(array)


func get_all_unchecked_hand(array: Array):
	hand.get_unchecked(array)


func check_left_hand():
	hand.check_left()


func check_right_hand():
	hand.check_right()

func check_initial_hand():
	hand.check_initial()
