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
