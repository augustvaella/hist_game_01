class_name ChallengeOptions extends Resource

@export var options: Array[Challenge]

func challenge(state: StageState, challenger: Character, opponent: Character):
	_choice_option().challenge(state, challenger, opponent)

# to be overriden
func _choice_option() -> Challenge:
	return null
