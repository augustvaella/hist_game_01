class_name CheckableNode extends Node
## CheckableNode is able to be checked to pointing the Node like UI options.

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
