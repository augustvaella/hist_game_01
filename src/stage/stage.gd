class_name Stage extends Node2D
## Stage is a state in the game on Startup.

signal proceeded(stage: Stage, state: StageState)
signal finished(stage: Stage, state: StageState)

signal listened_event(event: Event)

var _state: StageState

func _ready():
	pass

func proceed(state: StageState):
	_state = state
	_state.setup()
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
	listened_event.emit(StageInput.new().ini(event))


func resolve_stage():
	if not _state:
		Log.error(self, "resolve_stage() StageState is not found" % [])
		return

	_state.resolve_stage()
