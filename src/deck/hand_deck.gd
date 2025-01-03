class_name HandDeck extends Deck

@export var default_max_count: int

func add_card(card: Card):
	push_back_card(card)


func get_diff_count_default() -> int:
	var c = default_max_count - cards.size()
	if c < 0:
		return 0
	return c
