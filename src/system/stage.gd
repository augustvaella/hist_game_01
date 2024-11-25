class_name Stage extends Node2D

signal started(stage:Stage)
signal finished(stage:Stage)

func start():
	_start()
	started.emit(self)


func finish():
	_finish()
	finished.emit(self)
	
# to be overriden
func _start():
	pass
	

# to be overriden
func _finish():
	pass
