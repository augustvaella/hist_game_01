extends Node
## Singleton Master governs the game.

@export var master_resource_server: ResourceServer
@export var user_resource_server: ResourceServer
@export var master_instance_server: InstanceServer
@export var stage_server: InstanceServer
@export var effect_servers: Dictionary # <String, EffectServer>
@export var item_servers: Dictionary # <String, ObjectPool>
@export var is_debug_show: bool
@export var packed_scene_debug_window: PackedScene
var debug_window: DebugWindow

var _startup: Startup

func _ready():
	effect_servers = {}
	for s in find_child("EffectServers").get_children():
		effect_servers[s.name] = s

	item_servers = {}
	for s in find_child("ItemServers").get_children():
		item_servers[s.name] = s

	if is_debug_show:
		get_viewport().set_embedding_subwindows(false)
		debug_window = packed_scene_debug_window.instantiate()
		add_child(debug_window)
		get_viewport().set_embedding_subwindows(true)
		debug_window.show()


func get_startup() -> Startup:
	return _startup


func set_startup(startup: Startup):
	_startup = startup
	if is_debug_show:
		debug_window.set_startup(startup)


func emit_event_to_stage_state(event: Event):
	_startup.transfer_event_to_state(event)
