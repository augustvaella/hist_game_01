class_name DuelActor extends DuelCharacter
## DuelActor is an envelope of Actor to be dealed as UI(Node2D) on script.

@export var effect_shaker: EffectShaker

func set_element(character: Element):
	super.set_element(character)

func _listen_object(object: Object):
	super._listen_object(object)

	if object is EffectNumber.Pop:
		Master.effect_servers["number"].get_effect(self, object).do_effect()
	elif object is EffectShaker.Normal:
		effect_shaker.do_effect()


func _on_check():
	self.modulate = Color(1.0, 0.5, 0.5, 1.0)
	#info.display_name.text = "[%s]" % character.display_name

func _on_uncheck():
	self.modulate = Color(1.0, 1.0, 1.0, 1.0)
	#info.display_name.text = "%s" % character.display_name


func _mark():
	body.modulate = Color(0.5, 1.0, 0.5, 1.0)

func _unmark():
	body.modulate = Color(1.0, 1.0, 1.0, 1.0)
