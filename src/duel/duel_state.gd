class_name DuelState extends StageState

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
