class_name Actor extends Character

@export var morale: Morale
@export var army: Army
@export var supply: Supply

func _setup():
	super._setup()
	morale.changed.connect(func(): changed.emit())
	army.changed.connect(func(): changed.emit())
	supply.changed.connect(func(): changed.emit())

func damage_normal(state: StageState, challenger: Element):
	if challenger is Enemy:
		var v = 300
		#var v = army.get_value() - morale.get_ratio() * (challenger.vital.get_value())
		listened_object.emit(EffectNumber.Pop.new(v))
		listened_object.emit(EffectShaker.Normal.new())
		army.set_value(v)
	elif challenger is Actor:
		var v = army.get_value() - morale.get_ratio() * (challenger.army.get_value())
		listened_object.emit(EffectNumber.Pop.new(v))
		army.set_value(v)


func is_vital() -> bool:
	return army.is_condition(func(v, d, u): return d < v) and \
		morale.is_condition(func(v, d, u): return d < v) and \
		supply.is_condition(func(v, d, u): return d < v)


func _kill(state: StageState):
	state.friend_actors.erase(self)
	state.friend_actors_dead.push_back(self)
