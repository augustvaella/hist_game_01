class_name FieldSetDuelResolver extends DuelResolver
## 
##
## 
##

func resolve(state: StageState):
	state.stage.field.set_state(state)
	await state.stage.get_tree().create_timer(0.5).timeout
	next_resolver(state, "FriendSet")


func on_input(state: StageState, event: InputEvent):
	pass
