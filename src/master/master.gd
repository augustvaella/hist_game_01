extends Node

@export var log_level: Log.LogLevel
@export var resource_server: ResourceServer
@export var stage_manager: StageManager

func _ready():
	Log.change_level(log_level)
