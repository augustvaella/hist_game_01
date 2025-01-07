class_name DuelCard extends Item

signal decked ## emitted on Player's Deck
signal handed ## emitted on Player's Hand
signal discarded ## emitted on Player's Discard
signal removed ## emitted on removed from some deck


## DuelCard is an envelope of Card to be dealed as UI(Control) on script.
@export var texture_card: TextureRect
@export var texture_category: TextureRect
@export var texture_opponent: TextureRect

func _ready():
	super._ready()


func get_card_body() -> TextureRect:
	return texture_card

func set_element(element: Element):
	super.set_element(element)
	self.texture_card.texture = element.texture
	#texture_card.position = Vector2(-texture_card.size.x / 2, -texture_card.size.y / 2)
	#texture_card.pivot_offset = Vector2(texture_card.size.x / 2, texture_card.size.y / 2)
	texture_category.set_element(element)
	texture_opponent.set_element(element)
	info.set_element(element)


func reset_element():
	super.reset_element()
	self.texture = null


func _on_check():
	#self.modulate = Color(1.0, 0.5, 0.5, 1.0)
	info.trans_show()
	#info.set_display_name("[%s]" % card.display_name)


func _on_uncheck():
	#self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	info.hide()

func is_checkable() -> bool:
	return true
