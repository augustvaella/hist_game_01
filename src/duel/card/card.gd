class_name DuelCard extends Item

@export var card: Card

func set_element(card: Card):
	#super.set_element(card)
	self.card = card
	self.texture = card.texture
	info.set_element(card)

func reset_element():
	#super.reset_element()
	self.card = null
	self.texture = null

func get_card() -> Card:
	return card


func _on_check():
	info.set_display_name("[%s]" % card.display_name)


func _on_uncheck():
	info.set_display_name("%s" % card.display_name)


func _is_checkable() -> bool:
	return true
