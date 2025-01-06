extends Node2D
## Singleton Loading to view Now Loading announcement


@export var label_progress: Label

func _ready():
	pass

	
func refresh_load_status(resource_path: String, progress: Array):
	label_progress.text = "%s %d" % [resource_path, progress[0]]
