class_name DuelFoe extends CharacterField

func _ready():
	super._ready()
	item_server = Master.item_servers.duel_enemy


func set_state(state: StageState):
	super.set_state(state)
	items.resize(state.foe_field_limit_count)
	var elm = []
	elm.assign(state.foe_enemies)
	for i in range(items.size()):
		var e = elm.pop_front()
		if e:
			e.setup()
			items[i] = item_server.get_item(e)
			add_child(items[i])
		else:
			items[i] = item_server.get_empty_item()
			add_child(items[i])
		items[i].position = Vector2(randf_range(100.0, 1500.0), randf_range(0.0, 100.0))

func reset_state():
	super.reset_state()
	reset_elements()
	for item in items:
		remove_child(item)
		Master.item_servers.duel_enemy.return_enemy(item)
	items.resize(0)


func reserve_enemy(enemies: Array):
	var elm = []
	elm.assign(enemies)
	for item in items.filter(func(i): return not i.element.is_vital()):
		var e = elm.pop_front()
		if e:
			item.set_element(e)
