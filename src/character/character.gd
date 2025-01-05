class_name Character extends SetupResource
## Character creates the characters in the game
## representing the protagonist in the story as classified on script as Actor, Enemy... 

## emitted when the Character object tells an event to another object.
signal listened_object(object: Object)

@export var display_name: String

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D

var _changed_callables: Array[Callable]


func _setup():
	changed.connect(func(): listened_object.emit(Changed.new()))


func call_changed():
	_changed_callables.map(func(c): c.call(Changed.new()))


func set_listen_object(callable: Callable):
	#_changed_callables.append(callable)
	listened_object.connect(callable)


func cancel_listen_object(callable: Callable):
	#_changed_callables.erase(callable)
	listened_object.disconnect(callable)


func reset_listen_object():
	_changed_callables.clear()

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
