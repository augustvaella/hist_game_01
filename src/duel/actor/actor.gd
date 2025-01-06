class_name DuelActor extends DuelCharacter
## DuelActor is an envelope of Actor to be dealed as UI(Node2D) on script.

func set_element(character: Element):
	super.set_element(character)

func _listen_object(object: Object):
	super._listen_object(object)

	if object is EffectNumber.Pop:
		Master.effect_servers["number"].get_effect(self, object).do_effect()

func _on_check():
	self.modulate = Color(1.0, 0.5, 0.5, 1.0)
	#info.display_name.text = "[%s]" % character.display_name

func _on_uncheck():
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	#info.display_name.text = "%s" % character.display_name


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
