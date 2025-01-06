class_name DuelFormation extends SetupResource

@export var formations: Array[Vector2]

func _setup():
	pass

func get_size() -> int:
	return formations.size()

func get_position(index: int) -> Vector2:
	return formations[index]
