class_name DuelEvent extends Event

func _to_string() -> String:
	return "[DuelEvent#%d]" % [get_instance_id()]
