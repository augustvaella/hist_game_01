class_name DuelCard extends Item

var _card: Card


func set_card(card: Card):
	_card = card
	texture = card.texture
	info.set_card(card)


func get_card() -> Card:
	return _card


func _on_check():
	scale = Vector2(1.5, 1.5)


func _on_uncheck():
	scale = Vector2(1.0, 1.0)


func _is_checkable() -> bool:
	return true
