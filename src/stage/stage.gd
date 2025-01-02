class_name Stage extends Node2D

signal proceeded(stage: Stage, state: StageState)
signal finished(stage: Stage, state: StageState)

var _state: StageState

func proceed(state: StageState):
	_state = state
	_proceed(state)
	proceeded.emit(self, state)


# to be overriden
func _proceed(state: StageState):
	pass


func finish():
	finished.emit(_state)


# to be overriden
func _finish():
	pass
