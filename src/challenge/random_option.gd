class_name RandomChallengeOption extends ChallengeOptions

func _choice_option() -> Challenge:
	return options.pick_random()
