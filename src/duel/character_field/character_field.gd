class_name CharacterField extends ItemField

func return_killed_character():
	for chara in items:
		if not chara.element.is_vital():
			item_server.return_item(chara)
