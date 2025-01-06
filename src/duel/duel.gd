class_name Duel extends Stage

@export var field: DuelField
@export var friend: DuelFriend
@export var foe: DuelFoe
@export var hand: DuelCardHand
@export var deck: DuelDeck
@export var discard: DuelDiscard
@export var info: DuelInfo

func _ready():
	pass


func _proceed():
	await get_tree().create_timer(1.0).timeout


func _finish():
	await get_tree().create_timer(1.0).timeout
