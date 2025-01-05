# EffectNumberServer
extends ObjectPool

func _ready():
	super._ready()


func _create_object() -> Object:
	return Master.master_instance_server.copy_scene("res://src/effect/number/number.tscn")


func get_effect() -> EffectNumber:
	var c = get_object()
	return c


func return_effect(effect: EffectNumber):
	effect.get_parent().remove_child(effect)
	return_object(effect)
