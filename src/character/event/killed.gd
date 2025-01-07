class_name CharacterKilledEvent extends Event

var _character: Character
func ini(character: Character) -> CharacterKilledEvent:
	Log.trace(self, "%s" % [character])
	_character = character
	return self
func get_character() -> Character:
	return _character
