class_name Enemy extends Character

@export var vital: Vital
@export var challenge_options: ChallengeOptions

func _setup():
	super._setup()
	vital.changed.connect(func(): changed.emit())

func damage_normal(state: StageState, challenger: Element):
	if challenger is Actor:
		var k = challenger.army.value / 3
		var v = vital.get_value() - k
		listened_object.emit(EffectNumber.Pop.new(v))
		vital.set_value(v)


func is_vital() -> bool:
	return vital.is_condition(func(v, d, u): return d < v)
