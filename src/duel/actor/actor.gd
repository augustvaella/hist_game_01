class_name DuelActor extends DuelCharacter

func set_actor(actor: Actor):
	super.set_character(actor)
	# set_actor
	
	body.set_actor(actor)
	info.set_actor(actor)
