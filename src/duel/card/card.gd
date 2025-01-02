class_name DuelCard extends DuelCharacter

func set_card(card: Card):
	super.set_character(card)
	
	body.set_card(card)
	info.set_card(card)
