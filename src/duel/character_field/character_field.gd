class_name CharacterField extends Node2D

@export var characters: Array[DuelCharacter]


func get_max_character_count() -> int:
	return characters.size()


func set_state(state: DuelState):
	pass


func set_characters(charas: Array):
	var c = get_max_character_count()
	var count = c if charas.size() > c else charas.size()
	for i in range(count):
		set_character(charas[i], i)


func is_index_in_bound(index: int) -> bool:
	var count = get_max_character_count()
	return index > -count and index < count


func set_character(character: Character, index: int):
	if is_index_in_bound(index):
		characters[index].set_character(character)


func get_character(index: int) -> DuelCharacter:
	if is_index_in_bound(index):
		return characters[index]
	return null


func default_check():
	characters[0].check()


func left_check():
	var a = characters.filter(func(chara): return chara.is_checked)
	if a.size() > 0:
		if a != characters[0]:
			var p = a[0].get_pre_node()
			if p:
				characters.map(func(chara): chara.check() if chara == p else chara.uncheck())
	else:
		default_check()


func right_check():
	var a = characters.filter(func(chara): return chara.is_checked)
	if a.size() > 0:
		if a != characters[0]:
			var p = a[0].get_post_node()
			if p:
				characters.map(func(chara): chara.check() if chara == p else chara.uncheck())
	else:
		default_check()
