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
		listened_object.emit(EffectShaker.Normal.new())
		vital.set_value(v)


func is_vital() -> bool:
	return vital.is_condition(func(v, d, u): return d < v)


func _kill(state: StageState):
	state.foe_enemies.erase(self)
	state.foe_enemies_dead.push_back(self)
