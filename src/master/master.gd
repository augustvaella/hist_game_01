# Master
extends Node

@export var log_level: Log.LogLevel
@export var master_resource_server: ResourceServer
@export var user_resource_server: ResourceServer
@export var master_instance_server: InstanceServer
@export var stage_server: InstanceServer

var _startup: Startup

func _ready():
	Log.change_level(log_level)


func get_startup() -> Startup:
	return _startup


func set_startup(startup: Startup):
	_startup = startup
