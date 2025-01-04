class_name DuelEnemy extends DuelCharacter
#
func set_character(character: Character):
	super.set_character(character)


func _on_check():
	info.display_name.text = "[%s]" % character.display_name


func _on_uncheck():
	info.display_name.text = "%s" % character.display_name

func _is_checkable():
	return true


func get_pre_node() -> Node:
	match get_index():
		0:
			return get_sibling_node(1)
		1:
			return get_sibling_node(3)
		2:
			return get_sibling_node(0)
		3:
			return get_sibling_node(5)
		4:
			return get_sibling_node(2)
		5:
			return null
	return null

func get_post_node() -> Node:
	match get_index():
		0:
			return get_sibling_node(2)
		1:
			return get_sibling_node(0)
		2:
			return get_sibling_node(4)
		3:
			return get_sibling_node(1)
		4:
			return null
		5:
			return get_sibling_node(3)
	return null
