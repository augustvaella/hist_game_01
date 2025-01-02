class_name Stage extends Node2D

signal proceeded(stage: Stage, state: StageState)
signal finished(stage: Stage, state: StageState)

var _state: StageState

func _ready():
	pass
	

func proceed(state: StageState):
	_state = state
	await _proceed()
	proceeded.emit(self, state)


# to be overriden
func _proceed():
	return


func finish():
	await _finish()
	finished.emit(_state)


# to be overriden
func _finish():
	return
