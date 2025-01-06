class_name CharacterField extends ItemField

func return_killed_character():
	for chara in items:
		if not chara.element.is_vital():
			item_server.return_item(chara)

func is_all_vital() -> bool:
	for item in items:
		if not item.is_vital():
			return false
	return true

func is_all_dead() -> bool:
	for item in items:
		if item.is_vital():
			return false
	return true

func is_exist_vital() -> bool:
	return not is_all_dead()

func is_exist_dead() -> bool:
	return not is_all_vital()
