class_name CheckableNode extends MarkableNode
## CheckableNode is able to be checked to pointing the Node like UI options.

signal changed

@export var _is_checked: bool
var is_checked: bool:
	get:
		return _is_checked
	set(v):
		if _is_checked != v:
			_is_checked = v
			changed.emit()

func _ready():
	super._ready()

func check():
	if is_checkable():
		is_checked = true
		_on_check()


func uncheck():
	if is_checkable():
		is_checked = false
		_on_uncheck()


# to be overridden
func _on_check():
	pass

# to be overridden
func _on_uncheck():
	pass

# to be overridden
func is_checkable() -> bool:
	return false
