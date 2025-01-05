class_name DuelTurn extends Parameter

signal reached_max


func increase():
	value += 1

func reset():
	value = 0

func is_reached() -> bool:
	return value == max_value
