class_name DuelCard extends Item

var _card: Card


func set_card(card: Card):
	_card = card
	self.texture = card.texture
	info.set_card(card)


func get_card() -> Card:
	return _card


func _on_check():
	info.set_display_name("[%s]" % _card.display_name)


func _on_uncheck():
	info.set_display_name("%s" % _card.display_name)


func _is_checkable() -> bool:
	return true
