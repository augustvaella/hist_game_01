class_name DuelEnemyInfo extends DuelCharacterInfo

@export var vital: Label

func set_character(character: Character):
	super.set_character(character)
	#vital.text = "%d" % [character.vital.value]
	#character.vital.changed_value.connect(func(v, d, u): vital.text = "%d" % [v])

func reflesh_info(character: Character):
	super.reflesh_info(character)
	vital.text = "%d" % [character.vital.value]
