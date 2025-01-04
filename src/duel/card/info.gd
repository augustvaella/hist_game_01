class_name DuelCardInfo extends ItemInfo

func set_element(card: Card):
	#super.set_element(card)
	set_display_name(card.display_name)

func reset_element():
	pass
	#super.reset_element()
