class_name EffectServer extends ObjectPool

@export var instance_path: String

func _ready():
	super._ready()


func _create_object() -> Object:
	return Master.master_instance_server.copy_scene(instance_path)


func get_effect(parent: Node, object: Object) -> Effect:
	var c = get_object()
	c.set_effect(parent, object)
	return c


func return_effect(effect: Effect):
	effect.reset_effect()
	return_object(effect)
