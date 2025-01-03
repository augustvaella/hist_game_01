class_name Stage extends Node2D

signal proceeded(stage: Stage, state: StageState)
signal finished(stage: Stage, state: StageState)

signal listened_event(event: Event)

var _state: StageState

func _ready():
	pass

func proceed(state: StageState):
	_state = state
	_state.set_stage(self)
	listened_event.connect(transfer_event_to_state)
	await _proceed()
	proceeded.emit(self, state)
	resolve_stage()


func transfer_event_to_state(event: Event):
	_state.event_queue.append(event)


# to be overriden
func _proceed():
	return


func finish():
	await _finish()
	listened_event.disconnect(transfer_event_to_state)
	finished.emit(_state)


# to be overriden
func _finish():
	return


func _input(event: InputEvent):
	listened_event.emit(Event.StageInput.new(event))


func resolve_stage():
	if not _state:
		Log.error("[Stage#%d] resolve_stage() StageState is not found" % [get_instance_id()])
		return

	_state.resolve_stage()
