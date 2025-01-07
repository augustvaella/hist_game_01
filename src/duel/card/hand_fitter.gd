class_name DuelCardHandFitter extends DuelCardFitter

const ROTATION_MOD: float = PI / 2

@export var origin_global_position: Vector2

@export var init_position: Vector2
@export var rotation: float

@export var current_scale: Vector2
@export var normal_scale: Vector2

func _ready():
	super._ready()

func on_hand():
	is_enable = true
	origin_global_position = checkable_node.get_parent().global_position
	fit_node()

func on_deck():
	is_enable = false

func on_discard():
	is_enable = false

func on_remove():
	is_enable = false

func on_check():
	on_uncheck()
	target.scale = current_scale
	Log.trace(checkable_node, "HandFitter checked O%s P%s, R%f, S%s" % [origin_global_position, checkable_node.position, target.rotation, target.scale])


func get_direction(target_global_position: Vector2) -> Vector2:
	return origin_global_position.direction_to(target_global_position).rotated(rotation)


func get_distance() -> float:
	return Vector2(target.size.x * normal_scale.x, target.size.y * normal_scale.y).length()


func positioning(r: DuelCard):
	var dir = get_direction(r.global_position)
	var dis = get_distance()
	formationing(dir, dis)
	Log.trace(checkable_node, "HandFitter dir:%s dis:%f" % [dir, dis])


func formationing(direction: Vector2, distance: float):
	checkable_node.position = direction * distance
	target.rotation = direction.angle() + ROTATION_MOD


func init_positioning():
	var dir = get_direction(init_position + origin_global_position)
	var dis = get_distance()
	formationing(dir, dis)


func on_uncheck():
	target.scale = normal_scale
	var r = checkable_node.get_pre_node()
	if r:
		positioning(r)
	else:
		init_positioning()
	Log.trace(checkable_node, "HandFitter unchecked O%s P%s, R%f, S%s" % [origin_global_position, checkable_node.position, target.rotation, target.scale])
