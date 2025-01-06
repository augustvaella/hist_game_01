class_name DuelActorInfo extends DuelCharacterInfo

@export var army: Label
@export var morale: Label
@export var supply: Label

func set_element(character: Element):
	super.set_element(character)


func refresh_element(character: Element):
	super.refresh_element(character)
	refresh_army(character.army.value)
	refresh_morale(character.morale.value)
	refresh_supply(character.supply.value)
	

func refresh_army(value: int):
	army.text = "%d" % [value]

func refresh_morale(value: int):
	morale.text = "%d" % [value]

func refresh_supply(value: int):
	supply.text = "%d" % [value]
