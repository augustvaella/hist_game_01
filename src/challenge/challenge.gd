class_name Challenge extends Resource
## Challenge executes processes that challenger Character to opponent Characters.

signal challenged(challenge: Challenge)

@export var next_challenge: Challenge

func challenge(state: StageState, challenger: Character, opponent: Character):
	_challenge(state, challenger, opponent)
	challenged.emit(self)
	if next_challenge:
		next_challenge.challenge(state, challenger, opponent)

# to be overriden
func _challenge(state: StageState, challenger: Character, opponent: Character):
	pass
