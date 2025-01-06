class_name DuelCharacter extends Item
## DuelCharacter is an envelope of Element to be dealed as UI(Node2D) on script.


@export var body: DuelCharacterBody

func _listen_object(object: Object):
	if object is Character.Killed:
		kill(object.get_state())
		#Master.effect_servers["number"].get_effect(self, object).do_effect()


func kill(state: StageState):
	body.kill(state, element)
	info.kill(state, element)


func do_effect(effect_node: Node, object: Object):
		add_child(effect_node)
		await effect_node.do_effect(object)


func set_element(character: Element):
	super.set_element(character)
	body.set_element(character)
	info.set_element(character)
	refresh_element()


func reset_element():
	super.reset_element()
	body.reset_element()


func refresh_element():
	super.refresh_element()
	body.refresh_element(element)


func is_checkable():
	return true


class Empty extends DuelCharacter:
	pass
