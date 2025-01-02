# Master
extends Node

@export var log_level: Log.LogLevel
@export var master_resource_server: ResourceServer
@export var user_resource_server: ResourceServer
@export var instance_server: InstanceServer
@export var stage_server: InstanceServer

func _ready():
	Log.change_level(log_level)
