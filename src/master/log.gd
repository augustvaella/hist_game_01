extends Node

signal logged_error(text: String)
signal logged_warn(text: String)
signal logged_info(text: String)
signal logged_debug(text: String)
signal logged_trace(text: String)

@export var _log: Logger
var _logged: String
var _erasetag: RegEx

func _ready():
	_log.logged_error.connect(func(text: String): self.logged_error.emit(text))
	_log.logged_warn.connect(func(text: String): self.logged_warn.emit(text))
	_log.logged_info.connect(func(text: String): self.logged_info.emit(text))
	_log.logged_debug.connect(func(text: String): self.logged_debug.emit(text))
	_log.logged_trace.connect(func(text: String): self.logged_trace.emit(text))

	_log.logged_error.connect(add_log_to_text)
	_log.logged_warn.connect(add_log_to_text)
	_log.logged_info.connect(add_log_to_text)
	_log.logged_debug.connect(add_log_to_text)
	_log.logged_trace.connect(add_log_to_text)

	_erasetag = RegEx.new()
	_erasetag.compile("\\[color=[a-zA-Z0-9_\"\']+\\](.*)\\[/color\\]")

func _notification(what: int):
	if what == NOTIFICATION_CRASH:
		save_logged()


func add_log_to_text(text: String):
	_logged = "%s\n%s" % [_logged, text]


func save_logged():
	var d = Time.get_datetime_dict_from_system()
	var filename = "%d_%02d%02d_%02d%02d%02d.log" % [d.year, d.month, d.day, d.hour, d.minute, d.second]
	var file = FileAccess.open("user://%s" % [filename], FileAccess.WRITE)
	var txt = _erasetag.sub(_logged, "$1", true)
	file.store_string(txt)
	

func log_error(text: String):
	_log.log_error(text)

func log_warn(text: String):
	_log.log_warn(text)

func log_info(text: String):
	_log.log_info(text)

func log_debug(text: String):
	_log.log_debug(text)

func log_trace(text: String):
	_log.log_trace(text)


func error(object: Object, text: String):
	_log.log_error(get_text(object, text))


func warn(object: Object, text: String):
	_log.log_warn(get_text(object, text))


func info(object: Object, text: String):
	_log.log_info(get_text(object, text))


func debug(object: Object, text: String):
	_log.log_debug(get_text(object, text))

func trace(object: Object, text: String):
	_log.log_trace(get_text(object, text))

func get_text(object: Object, text: String) -> String:
	return "[%s] %s" % [gd(object), text]

func gd(variant: Variant) -> String:
	if variant:
		if variant is Object:
			var s = variant.get_script()
			if s:
				return "%s#%d" % [s.get_global_name(), variant.get_instance_id()]
			else:
				return "Object#%d" % [variant.get_instance_id()]
		elif variant is Dictionary:
			return "Dictionary"
		elif variant is Array:
			return "Array"
		elif variant is bool:
			return "bool"
		elif variant is int:
			return "int"
		elif variant is float:
			return "float"
		elif variant is String:
			return "String"
		elif variant is StringName:
			return "StringName"
		elif variant is NodePath:
			return "NodePath"
		elif variant is Vector2:
			return "Vector2"
		elif variant is Vector2i:
			return "Vector2i"
		elif variant is Rect2:
			return "Rect2"
		elif variant is Rect2i:
			return "Rect2i"
		elif variant is Vector3:
			return "Vector3"
		elif variant is Vector3i:
			return "Vector3i"
		elif variant is Vector4:
			return "Vector4"
		elif variant is Vector4i:
			return "Vector4i"
		elif variant is Transform2D:
			return "Transform2D"
		elif variant is Plane:
			return "Plane"
		elif variant is Projection:
			return "Projection"
		elif variant is Quaternion:
			return "Quaternion"
		elif variant is AABB:
			return "AABB"
		elif variant is Transform3D:
			return "Transform3D"
		elif variant is Color:
			return "Color"
		elif variant is RID:
			return "RID"
		elif variant is PackedByteArray:
			return "PackedByteArray"
		elif variant is PackedInt32Array:
			return "PackedInt32Array"
		elif variant is PackedInt64Array:
			return "PackedInt64Array"
		elif variant is PackedFloat32Array:
			return "PackedFloat32Array"
		elif variant is PackedFloat64Array:
			return "PackedFloat64Array"
		elif variant is PackedStringArray:
			return "PackedStringArray"
		elif variant is PackedVector2Array:
			return "PackedVector2Array"
		elif variant is PackedVector3Array:
			return "PackedVector3Array"
		elif variant is PackedVector4Array:
			return "PackedVector4Array"
		elif variant is PackedColorArray:
			return "PackedColorArray"
		elif variant is Signal:
			return "Signal"
		elif variant is Callable:
			return "Callable"
		return "Variant"
	return "null"
