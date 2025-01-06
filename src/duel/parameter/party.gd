class_name DuelParty extends SetupResource

@export var vitals: Array[Character]
@export var fronts: Array[Character]
@export var deads: Array[Character]

func _setup():
	pass

func reserve_character() -> Character:
	var v = vitals.pop_front()
	fronts.append(v)
	emit_changed()
	return v

func withdraw_character(character: Character):
	fronts.erase(character)
	deads.push_back(character)
	emit_changed()

func get_party(result: Array):
	result.assign(vitals)
	result.assign(fronts)
	result.assign(deads)

func get_reserves(result: Array):
	result.assign(vitals)

func get_vitals(result: Array):
	result.assign(fronts)

func get_deads(result: Array):
	result.assign(deads)
