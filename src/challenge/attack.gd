class_name ChallengeAttack extends Challenge

func challenge(state: StageState, challenger: Character, opponent: Character):
	opponent.damage_normal(state, challenger)
