class_name DuelCardInfo extends ItemInfo

func set_element(card: Element):
	super.set_element(card)
	#set_display_name(card.display_name)

func reset_element():
	super.reset_element()
