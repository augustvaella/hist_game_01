class_name DuelCharacter extends Item
## DuelCharacter is an envelope of Element to be dealed as UI(Node2D) on script.


@export var body: DuelCharacterBody

@export var _mark: bool
var mark: bool:
	get:
		return _mark
	set(v):
		_mark = v
		if v:
			_mark_character()
		else:
			_unmark_character()


func do_effect(effect_node: Node, object: Object):
		add_child(effect_node)
		await effect_node.do_effect(object)


func set_element(character: Element):
	super.set_element(character)
	character.listened_object.connect(listen_object)
	body.set_element(character)
	info.set_element(character)
	reflesh_element()


func reset_element():
	super.reset_element()
	body.reset_element()


func reflesh_element():
	super.reflesh_element()
	body.reflesh_element(element)


func mark_character():
	mark = true


func unmark_character():
	mark = false


# to be overriden
func _mark_character():
	pass


# to be overriden
func _unmark_character():
	pass


class Empty extends DuelCharacter:
	pass
