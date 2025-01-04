class_name Character extends Resource
@export var display_name: String

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D

# to be overriden
func is_vital() -> bool:
	return false

# to be overriden
func damage_normal(state: StageState, challenger: Character):
	pass
