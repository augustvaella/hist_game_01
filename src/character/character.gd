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
