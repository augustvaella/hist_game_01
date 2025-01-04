class_name Enemy extends Character

@export var vital: Vital

func damage_normal(state: StageState, challenger: Character):
	if challenger is Actor:
		var k = challenger.army.value / 3
		var v = vital.get_value() - k
		vital.set_value(v)


func is_vital() -> bool:
	return vital.is_condition(func(v, d, u): return d < v)
