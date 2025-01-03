class_name Duel extends Stage

@export var field: DuelField
@export var friend: DuelFriend
@export var foe: DuelFoe
@export var hand: DuelHand
@export var info: DuelInfo

@export var card_server: DuelCardServer

func _ready():
	pass


func _proceed():
	await get_tree().create_timer(1.0).timeout


func _finish():
	await get_tree().create_timer(1.0).timeout
