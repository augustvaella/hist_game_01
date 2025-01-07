class_name NodeFitter extends Node

@export var is_enable: bool
@export var target: Node

func _ready():
	if not target:
		target = get_parent()

func fit_node():
	if not is_enable:
		return
	_fit_node()

# to be overriden
func _fit_node():
	pass
