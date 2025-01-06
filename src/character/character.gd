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


# to be overriden
func _kill(state: StageState):
	pass


func kill(state: StageState):
	_kill(state)
	listened_object.emit(Killed.new(state))


class Killed extends RefCounted:
	var _state: StageState
	func _init(state: StageState):
		_state = state
	func get_state() -> StageState:
		return _state
