class_name EvalResultDuelResolver extends DuelResolver

const REGISTER_KEY_REST_TURNS: String = "eval result rest turns"

func resolve(state: StageState):
	state.register[REGISTER_KEY_REST_TURNS] -= 1
	print("evel result %d" % state.register[REGISTER_KEY_REST_TURNS])
	await state.stage.get_tree().create_timer(0.5).timeout

	if state.register[REGISTER_KEY_REST_TURNS] <= 0:
		next_resolver(state, "Result")
	else:
		next_resolver(state, "friend draw hand")
