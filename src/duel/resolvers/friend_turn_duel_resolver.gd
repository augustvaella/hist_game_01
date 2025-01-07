class_name FriendTurnDuelResolver extends DuelResolver

func resolve(state: StageState):
	state.turn.increase()
	await state.stage.get_tree().create_timer(0.5).timeout

	state.stage_emit_listened_event(NextResolver.new().ini(state.resolvers["friend draw hand"]))


func on_input(state: StageState, event: InputEvent):
	pass
