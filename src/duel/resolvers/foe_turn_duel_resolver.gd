class_name FoeTurnDuelResolver extends DuelResolver

const REGISTER_KEY_CHALLENGER = "foe challenger"

func resolve(state: StageState):
	#state.register[REGISTER_KEY_CHALLENGER] = ch

	while true:
		var ch = state.stage.foe.next_current_character()

		if ch is DuelCharacter.Empty:
			state.stage.foe.unmark_all_characters()
			break

		var op = state.stage.friend.characters.pick_random().character
		state.stage.foe.current_character.character.challenge_options.challenge(state, ch.character, op)
		await state.stage.get_tree().create_timer(0.5).timeout

	next_resolver(state, "EvalResult")
