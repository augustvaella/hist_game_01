class_name DuelFriend extends CharacterField

func _ready():
	super._ready()
	item_server = Master.item_servers.duel_actor

func set_state(state: StageState):
	super.set_state(state)
	items.resize(state.friend_field_limit_count)
	for i in range(items.size()):
		var e = state.friend_actors.pop_front()
		add_item(i, e)
		items[i].position = Vector2(randf_range(100.0, 1500.0), randf_range(0.0, 100.0))

func reset_state():
	super.reset_state()
	for item in items:
		remove_item(item)
	items.resize(0)
