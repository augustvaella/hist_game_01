class_name DuelFriend extends Node2D
const FRIEND_COUNT:int = 5
@export var actors: Array[DuelActor]

func set_state(state: DuelState):
	var count = FRIEND_COUNT if state.friend_actors.size() > FRIEND_COUNT else state.friend_actors.size()
	for i in range(count):
		set_actor(state.friend_actors[i], i)

func set_actor(actor: Actor, index: int):
	actors[index].set_actor(actor)
