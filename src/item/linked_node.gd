class_name LinkedNode extends CheckableNode


func get_pre_node() -> Node:
	var index = get_index()
	if index == 0:
		return null
	return get_parent().get_child(index - 1)

func get_post_node() -> Node:
	var index = get_index()
	var count = get_parent().get_child_count()
	if count == 1:
		return null
	elif index == count - 1:
		return null
	return get_parent().get_child(index + 1)
