class_name ChallengeOptions extends Resource
## Challenge selector automatically loaded on Enemy ...

@export var options: Array[Challenge]

func challenge(state: StageState, challenger: Element, opponent: Element):
	var opt = _choice_option()
	if opt:
		opt.challenge(state, challenger, opponent)

# to be overriden
func _choice_option() -> Challenge:
	return null
