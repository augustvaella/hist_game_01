class_name CharacterField extends ItemField

@export var party: DuelParty
@export var formation: DuelFormation

func set_state(state: StageState):
	super.set_state(state)
	party.setup()
	formation.setup()
	items.resize(formation.get_size())
	for i in range(items.size()):
		var e = party.reserve_character()
		add_item(i, e)
		items[i].position = formation.get_position(i)


func return_killed_character():
	for chara in items:
		if not chara.element.is_vital():
			item_server.return_item(chara)

func is_all_vital() -> bool:
	for item in items:
		if not item.is_vital():
			return false
	return true

func is_all_dead() -> bool:
	for item in items:
		if item.is_vital():
			return false
	return true

func is_exist_vital() -> bool:
	return not is_all_dead()

func is_exist_dead() -> bool:
	return not is_all_vital()

func reserve_characters(party: DuelParty):
	Log.trace(self, "#%d.reserve_characters()" % [get_instance_id()])
	items.map(func(item): item.reserve_character(party))
