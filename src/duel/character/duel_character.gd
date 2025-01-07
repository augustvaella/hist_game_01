class_name DuelCharacter extends Item
## DuelCharacter is an envelope of Element to be dealed as UI(Node2D) on script.


@export var body: DuelCharacterBody

func is_empty() -> bool:
	return not element

## DuelCharacter.is_vital() means differently (DuelCharacter has no character or the character is dead)
## from Character.is_vital() (the character is dead)
func is_vital() -> bool:
	if element and element.is_vital():
		return true
	return false


func _listen_object(object: Object):
	if object is Character.Killed:
		Log.trace(self, "_listen_object(%s)" % [Log.gd(object)])
		kill()


func kill():
	body.kill(element)
	info.kill(element)
	var e = CharacterKilledEvent.new().ini(self.element)
	reset_element()
	Master.emit_event_to_stage_state(e)
	Log.debug(self, "kill() %s" % [Log.gd(e)])

func do_effect(effect_node: Node, object: Object):
		add_child(effect_node)
		await effect_node.do_effect(object)


func set_element(character: Element):
	super.set_element(character)
	body.set_element(character)
	info.set_element(character)
	refresh_element()
	Log.debug(self, "set_element(%s)" % [Log.gd(character)])


func reset_element():
	super.reset_element()
	body.reset_element()


func refresh_element():
	super.refresh_element()
	body.refresh_element(element)


func is_checkable():
	if not element:
		return false
	else:
		if not element.is_vital():
			return false
	return true


func reserve_character(party: DuelParty):
	Log.trace(self, "reserve_character() from %s" % [Log.gd(party)])
	if not element:
		var e = party.reserve_character()
		if e:
			Log.debug(self, "reserve_characters() %s.reserve_character(%s)" % \
				[Log.gd(party), Log.gd(e)])
			set_element(e)


class Empty extends DuelCharacter:
	pass
