class_name DuelFoe extends CharacterField

func set_state(state: DuelState):
	super.set_state(state)
	set_characters(state.foe_enemies)
	await get_tree().create_timer(1.0).timeout
