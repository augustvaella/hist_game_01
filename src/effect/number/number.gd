class_name EffectNumber extends Effect

var tween: Tween

func _ready():
	self.text = String()

func do_effect():
	tween.play()
	await tween.finished
	Master.effect_servers["number"].return_effect(self)

func reset_effect():
	get_parent().remove_child(self)

func set_effect(parent: Node, object: Object):
	parent.add_child(self)
	if object is Pop:
		self.text = "%d" % object.get_number()

		var duration: float = 0.7
		var tp: float = 17.0
		var rt: float = 28.0

		tween = parent.get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(0, 0), 0)
		tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0)
		tween.tween_method(func(p: float): self.position=Vector2(p, (p - tp / 2.0) ** 2 - (tp ** 2) / 4.0), 0.0, rt, duration)
		tween.parallel().tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.2), duration)
	
class Pop extends RefCounted:
	var _number: int
	func _init(number: int):
		_number = number
	func get_number() -> int:
		return _number
