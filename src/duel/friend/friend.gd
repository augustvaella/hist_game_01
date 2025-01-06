class_name DuelFriend extends CharacterField

func _ready():
	super._ready()
	item_server = Master.item_servers.duel_actor

func set_state(state: StageState):
	elements = state.friend_actors
	formation = state.friend_formation
	super.set_state(state)


func reset_state():
	super.reset_state()
	for item in items:
		remove_item(item)
	items.resize(0)
