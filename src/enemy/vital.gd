class_name Vital extends Parameter

# to be overriden
func is_vital() -> bool:
	return value > min_value
