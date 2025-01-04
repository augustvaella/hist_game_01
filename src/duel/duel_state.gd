class_name DuelState extends StageState
# Field

# Friend
@export var friend_actors: Array[Actor]
@export var deck: PlayerDeck
@export var hand: HandDeck
@export var discard: DiscardDeck

# Foe
@export var foe_enemies: Array[Enemy]


func get_stage_name() -> String:
	return "duel"


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


func friend_hand_draw():
	var rc = deck.draw()
	if rc:
		var c = stage.card_server.get_card(rc)
		stage.hand.add_node(c)
	else:
		pass
	await stage.get_tree().create_timer(0.1).timeout
	

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


	# Duel Resolving
	#   Friend Set
	#   Foe Set
	#   Friend Turn
	#   Foe Turn 
	#   Eval Result -> Friend Turn / Result
	#   Result
	# End Duel Resolving
