class_name ChallengeAttack extends Challenge

func challenge(state: StageState, challenger: Element, opponent: Element):
	opponent.damage_normal(state, challenger)
