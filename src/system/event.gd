class_name Event extends Resource

func _to_string() -> String:
	return "[Event#%d]" % [get_instance_id()]

class Finish extends Event:
	pass

class NextResolver extends Event:
	var _resolver: Resolver

	func _init(resolver: Resolver):
		_resolver = resolver

	func get_resolver() -> Resolver:
		return _resolver

class StageInput extends Event:
	var _input_event: InputEvent

	func _init(input_event: InputEvent):
		_input_event = input_event

	func get_input_event() -> InputEvent:
		return _input_event
