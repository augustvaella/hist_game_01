class_name Challenge extends Resource

@export var next_challenge: Challenge

func challenge(state: StageState, challenger: Character, opponent: Character):
	_challenge(state, challenger, opponent)
	if next_challenge:
		next_challenge.challenge(state, challenger, opponent)

# to be overriden
func _challenge(state: StageState, challenger: Character, opponent: Character):
	pass
