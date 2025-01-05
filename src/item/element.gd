class_name Element extends SetupResource
## Element gives the unique informations to Item.

## emitted when the Character object tells an event to another object.
signal listened_object(object: Object)

@export var display_name: String

func _setup():
	changed.connect(func(): listened_object.emit(Changed.new()))

class Changed extends RefCounted:
	pass
