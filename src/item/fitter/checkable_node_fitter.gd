class_name CheckableNodeFitter extends NodeFitter

@export var checkable_node: CheckableNode

func _ready():
	super._ready()
	checkable_node.changed.connect(on_check_node)
	checkable_node.changed.connect(fit_node)

# to be overriden
func on_check_node():
	pass
