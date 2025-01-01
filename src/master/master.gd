# Master
extends Node

@export var log_level: Log.LogLevel
@export var resource_server: ResourceServer
@export var instance_server: InstanceServer

func _ready():
	Log.change_level(log_level)
