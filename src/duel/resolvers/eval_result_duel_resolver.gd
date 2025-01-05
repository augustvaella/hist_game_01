class_name EvalResultDuelResolver extends DuelResolver

const REGISTER_KEY_REST_TURNS: String = "eval result rest turns"

func resolve(state: StageState):
	#state.register[REGISTER_KEY_REST_TURNS] -= 1
	print("evel result %d" % state.turn.value)
	await state.stage.get_tree().create_timer(0.5).timeout

	if state.eval_result():
		next_resolver(state, "Result")
	else:
		next_resolver(state, "FriendTurn")
