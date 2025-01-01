class_name Stage extends Node2D

signal proceeded(stage: Stage, state: StageState)
signal finished(stage: Stage, result: StageResult)


func proceed(state: StageState):
	proceeded.emit(self, state)
	var result:StageResult = await _proceed(state)
	finished.emit(self, result)

# to be overriden
func _proceed(state: StageState)-> StageResult:
	return null
