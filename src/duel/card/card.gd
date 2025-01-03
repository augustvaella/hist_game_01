class_name DuelCard extends Item

func set_card(card: Card):
	texture = card.texture
	info.set_card(card)
