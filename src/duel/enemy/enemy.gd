class_name DuelEnemy extends DuelCharacter

func set_enemy(enemy: Enemy):
	super.set_character(enemy)

	body.set_enemy(enemy)
	info.set_enemy(enemy)
