extends Node2D

@export var label_progress: Label

func _ready():
	pass

	
func reflesh_load_status(resource_path: String, progress: Array):
	label_progress.text = "%s %d" % [resource_path, progress[0]]
