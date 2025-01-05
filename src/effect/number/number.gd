class_name EffectNumber extends Effect

func _ready():
	self.text = String()

func pop_number(object: Pop):
	self.text = "%d" % object.get_number()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 0)
	tween.tween_property(self, "position", Vector2(100, 100), 0.3)
	tween.play()
	await tween.finished
	EffectNumberServer.return_effect(self)

func do_effect(object: Object):
	if object is Pop:
		pop_number(object)

class Pop extends RefCounted:
	var _number: int
	func _init(number: int):
		_number = number
	func get_number() -> int:
		return _number
