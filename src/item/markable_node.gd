class_name MarkableNode extends Node

@export var _marker: bool
var marker: bool:
	get:
		return _marker
	set(v):
		_marker = v
		if v:
			_mark()
		else:
			_unmark()

func mark():
	marker = true


func unmark():
	marker = false

# to be overriden
func _mark():
	pass


# to be overriden
func _unmark():
	pass
