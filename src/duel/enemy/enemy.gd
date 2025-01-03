class_name DuelEnemy extends DuelCharacter

func set_enemy(enemy: Enemy):
	super.set_character(enemy)

	body.set_enemy(enemy)
	info.set_enemy(enemy)


func _on_check():
	info.display_name.text = "[%s]" % info.display_name.text

func _on_uncheck():
	info.display_name.text = "%s" % info.display_name.text
