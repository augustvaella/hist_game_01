class_name Character extends Resource

signal listened_object(object: Object)

@export var display_name: String

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D

# CALL IT BEFORE USE! 
# to be overriden
func setup():
	pass

func listen_character(callable: Callable):
	changed.connect(func(): callable.call(Changed.new()))
	listened_object.connect(callable)

func cancel_listen_character(callable: Callable):
	changed.disconnect(callable)
	listened_object.disconnect(callable)
	
func reset_listen_character():
	for c in changed.get_connections():
		changed.disconnect(c)

	for c in listened_object.get_connections():
		listened_object.disconnect(c)


# to be overriden
func is_vital() -> bool:
	return false

# to be overriden
func damage_normal(state: StageState, challenger: Character):
	pass

class Changed extends RefCounted:
	pass
