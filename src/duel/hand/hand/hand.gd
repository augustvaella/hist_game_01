class_name DuelCardHand extends Control

@export var container: Container

func get_current_checked() -> DuelCard:
	return container.get_current_checked()


func get_all_checked(array: Array):
	container.get_checked(array)


func get_all_unchecked(array: Array):
	container.get_unchecked(array)

func set_state(state: DuelState):
	await get_tree().create_timer(0.05).timeout


func add_card(state: DuelState, card: DuelCard):
	state.add_card_to_hand(card.get_card())
	container.add_child(card)
	if not container.is_exist_checked():
		check_initial()


func is_all_unchecked() -> bool:
	return container.is_all_unchecked()


func check_initial():
	container.check_initial()

		
func check_left():
	container.check_left()


func check_right():
	container.check_right()


func check_single(index: int):
	container.check_single(index)
