class_name DuelState extends StageState

# resolver
@export var initial_resolver: DuelResolver
@export var resolvers: Dictionary # Dictionary<String, DuelResolver>
@export var current_resolver: DuelResolver

# Duel Controlers
var duel: Duel

# Field

# Friend
@export var friend_actors: Array[Actor]
@export var deck: PlayerDeck
@export var hand: HandDeck
@export var discard: DiscardDeck

# Foe
@export var foe_enemies: Array[Enemy]

@export var register: Dictionary
@export var event_queue: Array[Event]

func set_duel(duel: Duel):
	self.duel = duel


func get_duel() -> Duel:
	return duel


func get_stage_name() -> String:
	return "duel"


func set_hand():
	await duel.hand.set_state(self)


func set_friend():
	await duel.friend.set_state(self)


func set_foe():
	await duel.foe.set_state(self)


func friend_hand_draw():
	await duel.hand.draw(self)


func draw_card_from_deck() -> Card:
	return deck.draw()


func add_card_to_hand(card: Card):
	hand.add_card(card)


func check_left_hand():
	duel.hand.check_left_hand()


func check_right_hand():
	duel.hand.check_right_hand()


func get_checked_hand() -> DuelCard:
	return duel.hand.current_get_checked_hand()


func duel_listened_event_emit(event: Event):
	duel.listened_event.emit(event)


func _on_input(event: DuelInputEvent):
	current_resolver.on_input(self, event.get_input_event())


func _on_event(event: Event):
	current_resolver.on_event(self, event)


func event_loop():
	while true:
		while event_queue.size() > 0:
			var event = event_queue.pop_front()
			if event is DuelFinishEvent:
				return null
			elif event is DuelNextResolverEvent:
				return event.get_resolver()
			elif event is DuelInputEvent:
				_on_input(event)
			else:
				_on_event(event)
		await duel.get_tree().process_frame

func resolve_duel():
	current_resolver = initial_resolver
	while current_resolver:
		current_resolver.resolve(self)
		current_resolver = await event_loop()

	Master.get_startup().change_stage(get_next_stage_state())

	# Duel Resolving
	#   Friend Set
	#   Foe Set
	#   Friend Turn
	#   Foe Turn 
	#   Eval Result -> Friend Turn / Result
	#   Result
	# End Duel Resolving
