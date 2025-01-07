class_name DuelState extends StageState

# Duel Resolving
#   Friend Set
#   Foe Set
#   Friend Turn
#   Foe Turn 
#   Eval Result -> Friend Turn / Result
#   Result
# End Duel Resolving

# Result
@export_category("Duel")
@export var result: Result


# Field
@export_category("Field")
@export var turn: DuelTurn
@export var field: Field

# Friend
@export_category("Friend")
@export var friend_field_limit_count: int
@export var friend_actors: Array[Actor]
@export var friend_actors_dead: Array[Actor]

@export var friend_party: DuelParty
@export var friend_formation: DuelFormation

@export var deck: PlayerDeck
@export var hand: HandDeck
@export var discard: DiscardDeck


# Foe
@export_category("Foe")
@export var foe_field_limit_count: int
@export var foe_enemies: Array[Enemy]
@export var foe_enemies_dead: Array[Enemy]

@export var foe_party: DuelParty
@export var foe_formation: DuelFormation


enum Result {
	LOSE,
	WIN,
	TIME_UP,
	NO_CONTEST,
	CANCEL,
}


func get_stage_name() -> String:
	return "duel"

func _setup():
	turn.changed.connect(func(): if turn.is_reached(): turn.reached_max.emit())

# to be overriden
# return true is GOTO Result
func eval_result() -> bool:
	return false

func set_hand():
	await stage.hand.set_state(self)


func set_deck():
	await stage.deck.set_state(self)


func set_discard():
	await stage.discard.set_state(self)


func set_friend():
	await stage.friend.set_state(self)


func set_foe():
	await stage.foe.set_state(self)


func check_left_hand():
	stage.hand.check_left()


func check_right_hand():
	stage.hand.check_right()


func check_left_actor():
	stage.friend.check_left()


func check_right_actor():
	stage.friend.check_right()


func check_left_enemy():
	stage.foe.check_left()


func check_right_enemy():
	stage.foe.check_right()


func select_friend_actors():
	var key = ChallengeDuelResolver.REGISTER_KEY_TYPE
	register[key] = []
	stage.friend.get_all_checked(register[key])
	stage.friend.uncheck_all()

func select_foe_enemies():
	var key = ChallengeDuelResolver.REGISTER_KEY_TYPE
	register[key] = []
	stage.foe.get_all_checked(register[key])
	stage.foe.uncheck_all()

func get_checked_hand() -> DuelCard:
	return stage.hand.get_current_checked()

func cancel_select_all():
	stage.foe.uncheck_all()
	stage.friend.uncheck_all()


func _on_event(event: Event):
	super._on_event(event)
	if event is Character.KilledEvent:
		var chara = event.get_character()
		Log.debug(self, "Character.KilledEvent %s" % [chara])
		Log.trace(self, "%s is Enemy: %s" % [chara, chara is Enemy])
		if chara is Actor:
			stage.friend.reserve_characters(friend_party)
		elif chara is Enemy:
			stage.foe.reserve_characters(foe_party)
		if eval_result():
			stage.listened_event.emit(Event.NextResolver.new(resolvers["Result"]))


func _on_input(event: Event):
	var ev = event.get_input_event()
	if ev.is_action_pressed("Loud"):
		stage.deck.toggle_visible_contents()
	elif ev.is_action_pressed("Roar"):
		stage.discard.toggle_visible_contents()

	super._on_input(event)
