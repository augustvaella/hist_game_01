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


func set_friend():
	await stage.friend.set_state(self)


func set_foe():
	await stage.foe.set_state(self)


func friend_hand_draw():
	await stage.hand.draw(self)


func draw_card_from_deck() -> Card:
	return deck.draw()


func add_card_to_hand(card: Card):
	hand.add_card(card)


func check_left_hand():
	stage.hand.check_left_hand()


func check_right_hand():
	stage.hand.check_right_hand()


func check_left_actor():
	stage.friend.left_check()


func check_right_actor():
	stage.friend.right_check()


func get_checked_hand() -> DuelCard:
	return stage.hand.current_get_checked_hand()


	# Duel Resolving
	#   Friend Set
	#   Foe Set
	#   Friend Turn
	#   Foe Turn 
	#   Eval Result -> Friend Turn / Result
	#   Result
	# End Duel Resolving
