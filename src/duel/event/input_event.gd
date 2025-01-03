class_name DuelInputEvent extends DuelEvent

var _input_event: InputEvent

func _init(input_event: InputEvent):
	_input_event = input_event


func get_input_event() -> InputEvent:
	return _input_event
