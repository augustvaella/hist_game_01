# Master
extends Node

@export var log_level: Log.LogLevel
@export var master_resource_server: ResourceServer
@export var user_resource_server: ResourceServer
@export var master_instance_server: InstanceServer
@export var stage_server: InstanceServer

@export var is_debug: bool
@export var packed_scene_debug_window: PackedScene
var debug_window: DebugWindow

var _startup: Startup

func _ready():
	Log.change_level(log_level)
	
	if is_debug:
		get_viewport().set_embedding_subwindows(false)
		debug_window = packed_scene_debug_window.instantiate()
		add_child(debug_window)
		get_viewport().set_embedding_subwindows(true)


func get_startup() -> Startup:
	return _startup


func set_startup(startup: Startup):
	_startup = startup
	if is_debug:
		debug_window.set_startup(startup)
