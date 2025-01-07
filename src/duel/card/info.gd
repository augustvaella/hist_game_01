class_name DuelCardInfo extends ItemInfo

@export var label_category: Label
@export var label_rarity: Label
@export var label_opponent_select: Label
@export var label_sacrifice: Label
@export var label_challenges: Label
@export var label_flavor: Label
@export var offset_position: Vector2
func set_element(card: Element):
	super.set_element(card)
	label_category.text = Card.get_category_display_name(card.category)
	label_rarity.text = Card.get_rarity_display_name(card.rarity)
	label_opponent_select.text = Card.get_opponent_select_display_name(card.category)
	label_sacrifice.text = Card.get_sacrifice_display_name(card.category)
	label_challenges.text = card.challenge.get_document()
	label_flavor.text = card.display_flavor_text
	position = position + offset_position
	hide()

func reset_element():
	super.reset_element()

func trans_show():
	var t = get_tree().create_tween()
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	show()
	t.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.2)
	t.play()
