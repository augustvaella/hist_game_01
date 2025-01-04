class_name CharacterField extends CheckableNodeCollector

@export var characters: Array[DuelCharacter]
@export var current_character: DuelCharacter

func get_max_character_count() -> int:
	return characters.size()


func set_state(state: DuelState):
	reset_current_character()


func reset_current_character():
	current_character = characters[0]

func next_current_character() -> bool:
	var next_index = characters.find(current_character) + 1
	if next_index > 0 and next_index < get_max_character_count():
		current_character = characters[next_index]
		return true
	reset_current_character()
	return false


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
