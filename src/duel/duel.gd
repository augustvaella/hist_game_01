class_name Duel extends Stage

signal listened_event(event: Event)

@export var field: DuelField
@export var friend: DuelFriend
@export var foe: DuelFoe
@export var hand: DuelHand
@export var info: DuelInfo

@export var card_server: DuelCardServer

func _ready():
	super._ready()
	proceeded.connect(func(stage: Stage, state: StageState): resolve_duel())
	listened_event.connect(func(event): _state.event_queue.append(event))


func _input(event: InputEvent):
	listened_event.emit(DuelInputEvent.new(event))


func resolve_duel():
	_state.resolve_duel()


func _proceed():
	_state.set_duel(self)
	await get_tree().create_timer(1.0).timeout


func _finish():
	await get_tree().create_timer(1.0).timeout
