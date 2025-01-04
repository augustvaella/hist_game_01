class_name CharacterField extends CheckableNodeCollector

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
