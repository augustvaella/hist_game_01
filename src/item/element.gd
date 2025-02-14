class_name Element extends SetupResource
## Element gives the unique informations to Item.
##
## Element -> Card
## Element -> Character -> Actor, Enemy ...


## emitted when the Element object tells an event to another object.
signal listened_object(object: Object)

@export var display_name: String

func _setup():
	changed.connect(func(): listened_object.emit(Changed.new()))

class Changed extends RefCounted:
	func _to_string() -> String:
		return "[Element.Changed#%d]" % [get_instance_id()]
