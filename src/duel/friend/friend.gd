class_name DuelFriend extends CharacterField

func set_state(state: DuelState):
	set_characters(state.friend_actors)
	await get_tree().create_timer(1.0).timeout
