extends Node

signal logged_error(text: String)
signal logged_warn(text: String)
signal logged_info(text: String)
signal logged_debug(text: String)
signal logged_trace(text: String)

@export var _log: Logger
 
func _ready():
	_log.logged_error.connect(func(text: String): self.logged_error.emit(text))
	_log.logged_warn.connect(func(text: String): self.logged_warn.emit(text))
	_log.logged_info.connect(func(text: String): self.logged_info.emit(text))
	_log.logged_debug.connect(func(text: String): self.logged_debug.emit(text))
	_log.logged_trace.connect(func(text: String): self.logged_trace.emit(text))

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
			return "%s#%d" % [variant.get_script().get_global_name(), variant.get_instance_id()]
		return variant.to_string()
	return "null"
