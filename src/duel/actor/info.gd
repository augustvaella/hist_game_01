class_name DuelActorInfo extends DuelCharacterInfo

@export var army: Label
@export var morale: Label
@export var supply: Label

func set_character(character: Character):
	super.set_character(character)

	army.text = "%d" % [character.army.value]
	morale.text = "%d" % [character.morale.value]
	supply.text = "%d" % [character.supply.value]
	
	character.army.changed_value.connect(reflesh_army)
	character.morale.changed_value.connect(reflesh_morale)
	character.supply.changed_value.connect(reflesh_supply)

func reflesh_army(value: int, min: int, max: int):
	army.text = "%d" % [value]

func reflesh_morale(value: int, min: int, max: int):
	morale.text = "%d" % [value]

func reflesh_supply(value: int, min: int, max: int):
	supply.text = "%d" % [value]
