class_name Duel extends Stage

@export var initial_resolver: DuelResolver
@export var resolvers: Dictionary

@export var field: DuelField
@export var friend: DuelFriend
@export var foe: DuelFoe
@export var hand: DuelHand
@export var info: DuelInfo

func _ready():
	super._ready()
	resolvers = {}
	
	for c in get_children():
		if c is DuelResolver:
			resolvers[c.name] = c
		
	proceeded.connect(func(stage: Stage, state: StageState): resolve_duel())


func resolve_duel():
	await get_tree().create_timer(1.0).timeout
	# Duel Resolving
	#   Friend Set
	#   Foe Set
	#   Friend Turn
	#   Foe Turn 
	#   Eval Result -> Friend Turn / Result
	#   Result
	# End Duel Resolving
	var resolver: DuelResolver = initial_resolver
	while resolver:
		resolver.resolve(_state)
		resolver = await resolver.next_resolver

	Master.get_startup().change_stage(_state.get_next_stage_state())


func _proceed():
	_state.set_duel(self)
	await get_tree().create_timer(1.0).timeout


func _finish():
	await get_tree().create_timer(1.0).timeout
