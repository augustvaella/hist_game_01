class_name EffectShaker extends Effect

@export var target: Node2D
@export var amp: float
@export var from: float
@export var to: float
@export var duration: float

var original_position: Vector2
var tween: Tween

func do_effect():
	original_position = target.position
	tween = target.get_tree().create_tween()
	tween.tween_method(func(p: float): target.position = original_position + Vector2(randf() * p * amp, randf() * p * amp), from, to, duration)
	tween.play()
	await tween.finished
	target.position = original_position
	tween = null

func set_effect(parent: Node, object: Object):
	pass
	
class Normal extends RefCounted:
	pass
