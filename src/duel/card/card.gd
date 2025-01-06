class_name DuelCard extends Item
## DuelCard is an envelope of Card to be dealed as UI(Control) on script.

func set_element(element: Element):
	super.set_element(element)
	self.texture = element.texture
	info.set_element(element)


func reset_element():
	super.reset_element()
	self.texture = null


func _on_check():
	self.modulate = Color(1.0, 0.5, 0.5, 1.0)
	#info.set_display_name("[%s]" % card.display_name)


func _on_uncheck():
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	info.set_display_name("%s" % element.display_name)


func _is_checkable() -> bool:
	return true
