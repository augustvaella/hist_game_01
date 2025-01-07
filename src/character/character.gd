class_name Character extends Element
## Element needs StageState to set compared to Item.

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D


# to be overriden
func is_vital() -> bool:
	return false


# to be overriden
func damage_normal(state: StageState, challenger: Element):
	pass

func eval_vital():
	if not is_vital():
		kill()


# to be overriden
func _kill():
	pass


func kill():
	_kill()
	listened_object.emit(Killed.new())


class Killed extends RefCounted:
	pass

class KilledEvent extends Event:
	var _character: Character
	func init(character: Character) -> KilledEvent:
		Log.trace(self, "%s" % [character])
		_character = character
		return self
	func get_character() -> Character:
		return _character
