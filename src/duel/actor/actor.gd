class_name DuelActor extends DuelCharacter
#
func set_character(character: Character):
	super.set_character(character)

func _on_check():
	info.display_name.text = "[%s]" % info.display_name.text

func _on_uncheck():
	info.display_name.text = "%s" % info.display_name.text
