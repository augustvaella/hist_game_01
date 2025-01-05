class_name DuelActor extends DuelCharacter

func set_character(character: Character):
	super.set_character(character)

func _listen_object(object: Object):
	if object is EffectNumber.Pop:
		do_effect(EffectNumberServer.get_effect(), object)

func _on_check():
	self.modulate = Color(1.0, 0.5, 0.5, 1.0)
	#info.display_name.text = "[%s]" % character.display_name

func _on_uncheck():
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	#info.display_name.text = "%s" % character.display_name

func _is_checkable():
	return true

func _mark_character():
	body.modulate = Color(0.5, 1.0, 0.5, 1.0)

func _unmark_character():
	body.modulate = Color(1.0, 1.0, 1.0, 1.0)

func get_pre_node() -> Node:
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
	return null

func get_post_node() -> Node:
	match get_index():
		0:
			return get_sibling_node(1)
		1:
			return get_sibling_node(3)
		2:
			return get_sibling_node(0)
		3:
			return null
		4:
			return get_sibling_node(2)
	return null
