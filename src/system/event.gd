class_name Event extends Resource
## Event uses in the State-Revolver System.

func _to_string() -> String:
	return "[Event#%d]" % [get_instance_id()]

## throw it when the State will finish.
class Finish extends Event:
	pass

## throw it when the state will go to the next Resolver.
class NextResolver extends Event:
	var _resolver: Resolver

	func _init(resolver: Resolver):
		_resolver = resolver

	func get_resolver() -> Resolver:
		return _resolver

## throw it on the Stage received InputEvent.
class StageInput extends Event:
	var _input_event: InputEvent

	func _init(input_event: InputEvent):
		_input_event = input_event

	func get_input_event() -> InputEvent:
		return _input_event
