class_name DuelFoe extends CharacterField

func _ready():
	super._ready()
	item_server = Master.item_servers.duel_enemy


func set_state(state: StageState):
	party = state.foe_party
	formation = state.foe_formation
	super.set_state(state)


func reset_state():
	super.reset_state()
	for item in items:
		remove_item(item)
	items.resize(0)
