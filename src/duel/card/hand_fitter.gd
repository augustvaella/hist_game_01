class_name DuelCardHandFitter extends DuelCardFitter

const  ROTATION_MOD:float = PI / 2

@export var origin_position: Vector2

@export var init_position: Vector2
@export var current_position_rotation: float
@export var normal_position_rotation: float

@export var rotation: float

@export var current_scale: Vector2
@export var normal_scale: Vector2

func _ready():
	super._ready()

func on_hand():
	is_enable = true
	origin_position = checkable_node.get_parent().global_position
	fit_node()

func on_deck():
	is_enable = false

func on_discard():
	is_enable = false

func on_remove():
	is_enable = false

func on_check():
	target.scale = current_scale
	var r = checkable_node.get_pre_node()
	if r:
		positioning(r)
	else:
		init_positioning()
	Log.trace(checkable_node, "HandFitter checked O%s P%s, R%f, S%s" % [origin_position, checkable_node.position, target.rotation, target.scale])

func positioning(r: DuelCard):
	var dir = r.global_position - origin_position
	checkable_node.position = dir.rotated(current_position_rotation)
	target.rotation = origin_position.angle_to_point(checkable_node.position) + ROTATION_MOD
	Log.trace(checkable_node, "HandFitter dir:%s" % [dir])

func init_positioning():
	checkable_node.position = init_position
	target.rotation = origin_position.angle_to_point(checkable_node.position) + ROTATION_MOD

func on_uncheck():
	target.scale = normal_scale
	var r = checkable_node.get_pre_node()
	if r:
		positioning(r)
	else:
		init_positioning()
	Log.trace(checkable_node, "HandFitter unchecked O%s P%s, R%f, S%s" % [origin_position, checkable_node.position, target.rotation, target.scale])
