class_name LinkedCheckableNode extends Node

@export var is_checked: bool

func check():
	if _is_checkable():
		is_checked = true
		_on_check()


func uncheck():
	if _is_checkable():
		is_checked = false
		_on_uncheck()


# to be overridden
func _on_check():
	pass

# to be overridden
func _on_uncheck():
	pass

# to be overridden
func _is_checkable() -> bool:
	return false


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
