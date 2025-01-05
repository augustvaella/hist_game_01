class_name EffectNumber extends Label

func _ready():
	self.text = String()

func pop_number(number: int):
	self.text = "%d" % number
	self.show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(0, 0), 0)
	tween.tween_property(self, "position", Vector2(100, 100), 0.3)
	tween.play()
	await tween.finished
	EffectNumberServer.return_effect(self)

class Pop extends RefCounted:
	var _number: int
	func _init(number: int):
		_number = number
	func get_number() -> int:
		return _number
