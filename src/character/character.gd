class_name Character extends SetupResource
## Character creates the characters in the game
## representing the protagonist in the story as classified on script as Actor, Enemy... 

## emitted when the Character object tells an event to another object.
signal listened_object(object: Object)

@export var display_name: String

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D

func _setup():
	changed.connect(func(): listened_object.emit(Changed.new()))


# to be overriden
func is_vital() -> bool:
	return false


# to be overriden
func damage_normal(state: StageState, challenger: Character):
	pass


class Changed extends RefCounted:
	pass
