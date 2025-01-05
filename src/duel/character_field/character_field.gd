class_name CharacterField extends CheckableNodeCollector

@export var characters: Array[DuelCharacter]
@export var current_character: DuelCharacter

func get_max_character_count() -> int:
	return characters.size()


func set_state(state: DuelState):
	reset_current_character()

func unmark_all_characters():
	characters.map(func(chara): chara.unmark_character())
	
	
func mark_current_character():
	characters.map(func(chara): chara.mark_character() if chara == current_character else chara.unmark_character())

func reset_current_character():
	current_character = null
	mark_current_character()
	


func next_current_character() -> DuelCharacter:
	if not current_character:
		current_character = characters[0]
		mark_current_character()
		return current_character

	var next_index = characters.find(current_character) + 1
	if next_index > 0 and next_index < get_max_character_count():
		current_character = characters[next_index]
		mark_current_character()
		return current_character
	reset_current_character()
	return DuelCharacter.Empty.new()


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
