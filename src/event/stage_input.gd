class_name StageInput extends Event
## throw it on the Stage received InputEvent.

var _input_event: InputEvent

func ini(input_event: InputEvent) -> StageInput:
	_input_event = input_event
	return self

func get_input_event() -> InputEvent:
	return _input_event
