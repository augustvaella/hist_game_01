class_name DuelCardHandFitter extends DuelCardFitter

const ROTATION_MOD: float = PI / 2

@export var origin_global_position: Vector2
@export var default_direction: Vector2

@export var top_node_direction: Vector2
@export var top_node_length: float
@export var rotation: float
@export var piling_rotation: float

@export var length_current_proceed: float

@export var current_scale: Vector2
@export var normal_scale: Vector2

func _ready():
	super._ready()
	checkable_node.piled.connect(on_pile)
	checkable_node.unpiled.connect(on_unpile)

func on_pile():
	top_node_direction = top_node_direction.rotated(-piling_rotation)
	fit_node()
	Log.trace(checkable_node, "DuelCardHandFitter piled init%s" % [top_node_direction])


func on_unpile():
	top_node_direction = top_node_direction.rotated(piling_rotation)
	fit_node()
	Log.trace(checkable_node, "DuelCardHandFitter unpiled init%s" % [top_node_direction])


func on_hand():
	is_enable = true
	origin_global_position = checkable_node.get_parent().global_position
	top_node_direction = default_direction
	fit_node()

func on_deck():
	is_enable = false

func on_discard():
	is_enable = false

func on_remove():
	is_enable = false


func on_check():
	target.scale = current_scale
	locate_card()
	checkable_node.position = checkable_node.position - checkable_node.position.direction_to(Vector2(1.0, 1.0)) * length_current_proceed
	Log.trace(checkable_node, "check P%s" % [checkable_node.position])


func get_direction(target_global_position: Vector2) -> Vector2:
	return origin_global_position.direction_to(target_global_position)


#
	#return Vector2(target.size.x * normal_scale.x, target.size.y * normal_scale.y).length()


func locate_card():
	var r = checkable_node.get_pre_node()

	var d = r.global_position if r else top_node_direction * top_node_length - origin_global_position

	var dir = get_direction(d)
	#var dis = get_distance()
	var dis = top_node_length
	var target_length = Vector2(target.size.x * target.scale.x, target.size.y * target.scale.y).length()

	checkable_node.position = dir.rotated(rotation) * dis if r else dir * dis
	checkable_node.position += Vector2(target_length, 0).rotated(checkable_node.position.angle())
	#target.position = -Vector2(target.size.x * target.scale.x / 2, target.size.y * target.scale.y)
	target.rotation = dir.angle() + ROTATION_MOD

	Log.trace(checkable_node, "HandFitter dir:%s dis:%f x:%s" % [dir, dis, target_length])
	Log.trace(checkable_node, "HandFitter O%s P%s, R%f, S%s" % [origin_global_position, checkable_node.position, target.rotation, target.scale])


func on_uncheck():
	target.scale = normal_scale
	locate_card()
