class_name Event extends Resource

func _to_string() -> String:
	return "[Event#%d]" % [get_instance_id()]
