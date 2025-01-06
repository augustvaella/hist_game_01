class_name FoeTurnDuelResolver extends DuelResolver

const REGISTER_KEY_CHALLENGER = "foe challenger"

func resolve(state: StageState):
	#state.register[REGISTER_KEY_CHALLENGER] = ch

	while true:
		var ch = state.stage.foe.next_current_item()

		if not ch:
			break

		var op = state.stage.friend.items.pick_random().element
		state.stage.foe.current_item.element.challenge_options.challenge(state, ch.element, op)

		if not op.is_vital():
			op.kill(state)

		if not ch.element.is_vital():
			ch.kill(state)

		state.stage.friend.reserve_actor(state.friend_actors)
		state.stage.foe.reserve_enemy(state.foe_enemies)

		if state.eval_result():
			next_resolver(state, "Result")


		await state.stage.get_tree().create_timer(0.5).timeout

	next_resolver(state, "EvalResult")
