class_name FriendChallengeDuelResolver extends DuelResolver

const REGISTER_KEY_OPPONENTS: String = "challenge opponents" # Array[Character]

func resolve(state: StageState):
	pass
	# state.get_duel().listened_event.emit(DuelNextResolverEvent.new(state.resolvers["friend hand select"]))


func on_input(state: StageState, event: InputEvent):
	if event.is_action_pressed("Left"):
		pass
	elif event.is_action_pressed("Right"):
		pass
