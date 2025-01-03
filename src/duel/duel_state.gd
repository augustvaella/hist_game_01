class_name DuelState extends StageState

# resolver
@export var initial_resolver: DuelResolver
@export var resolvers: Dictionary # Dictionary<String, DuelResolver>
var _current_resolver: DuelResolver

# Duel Controlers
var _duel: Duel

# Field

# Friend
@export var friend_actors: Array[Actor]
@export var deck: PlayerDeck
@export var hand: HandDeck
@export var discard: DiscardDeck

# Foe
@export var foe_enemies: Array[Enemy]


func set_duel(duel: Duel):
	_duel = duel


func get_duel() -> Duel:
	return _duel


func get_stage_name() -> String:
	return "duel"


func set_hand():
	await _duel.hand.set_state(self)


func set_friend():
	await _duel.friend.set_state(self)


func set_foe():
	await _duel.foe.set_state(self)


func begin_friend_turn():
	await _duel.hand.draw(self)
	await _duel.hand.draw(self)
	await _duel.hand.draw(self)


func draw_card_from_deck() -> Card:
	return deck.draw()


func add_card_to_hand(card: Card):
	hand.add_card(card)

func _on_input(event: DuelInputEvent):
	_current_resolver.on_input(self, event.get_input_event())


func event_loop():
	while true:
		var event = await _duel.listened_event
		if event is DuelNextResolverEvent:
			return event.get_resolver()
		elif event is DuelInputEvent:
			_on_input(event)
		elif event is DuelFinishEvent:
			return null

func resolve_duel():
	_current_resolver = initial_resolver
	while _current_resolver:
		_current_resolver.resolve(self)
		_current_resolver = await event_loop()

	Master.get_startup().change_stage(get_next_stage_state())

	# Duel Resolving
	#   Friend Set
	#   Foe Set
	#   Friend Turn
	#   Foe Turn 
	#   Eval Result -> Friend Turn / Result
	#   Result
	# End Duel Resolving
