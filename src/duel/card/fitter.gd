class_name DuelCardFitter extends CheckableNodeFitter

func _ready():
	super._ready()
	checkable_node.handed.connect(on_hand)
	checkable_node.decked.connect(on_deck)
	checkable_node.discarded.connect(on_discard)
	checkable_node.removed.connect(on_remove)


# to be overriden
func on_hand():
	pass

# to be overriden
func on_deck():
	pass

# to be overriden
func on_discard():
	pass

# to be overriden
func on_remove():
	pass

func _fit_node():
	if checkable_node.is_checked:
		on_check()
	else:
		on_uncheck()

# to be overriden
func on_check():
	pass

# to be overriden
func on_uncheck():
	pass
