class_name Character extends SetupResource

signal listened_object(object: Object)

@export var display_name: String

@export var chat_texture: Texture2D
@export var duel_texture: Texture2D

var _changed_callables: Array[Callable]

func _setup():
	_changed_callables = []
	changed.connect(call_changed)

func call_changed():
	_changed_callables.map(func(c): c.call(Changed.new()))

func set_listen_object(callable: Callable):
	_changed_callables.append(callable)
	listened_object.connect(callable)

func cancel_listen_object(callable: Callable):
	_changed_callables.erase(callable)
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
