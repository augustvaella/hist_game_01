class_name Morale extends Parameter

func get_ratio() -> float:
	return get_value() / (get_max() - get_min())
