class_name DuelEnemyInfo extends DuelCharacterInfo

@export var vital: Label

func set_element(character: Element):
	super.set_element(character)
	#vital.text = "%d" % [character.vital.value]
	#character.vital.changed_value.connect(func(v, d, u): vital.text = "%d" % [v])

func refresh_element(character: Element):
	super.refresh_element(character)
	vital.text = "%d" % [character.vital.value]
