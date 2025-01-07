class_name Logger extends Node
## Log

signal logged_error(text: String)
signal logged_warn(text: String)
signal logged_info(text: String)
signal logged_debug(text: String)
signal logged_trace(text: String)

@export var _level: LogLevel
var level: LogLevel:
	get:
		return _level
	set(v):
		change_level()

var _handlers: Array[Callable]

@export var _is_print: bool
var is_print: bool:
	get:
		return _is_print
	set(v):
		if v:
			disconnect_to_print()
			connect_to_print()
		else:
			disconnect_to_print()

@export var is_rich_text: bool

func _ready():
	_handlers = [
		_dummy,
		_dummy,
		_dummy,
		_dummy,
		_dummy,
	]
	
	change_level()

func connect_to_print():
	match level:
		LogLevel.ERROR:
			logged_error.connect(_print_error)
		LogLevel.WARN:
			logged_error.connect(_print_error)
			logged_warn.connect(_print_warn)
		LogLevel.INFO:
			logged_error.connect(_print_error)
			logged_warn.connect(_print_warn)
			logged_info.connect(_print_info)
		LogLevel.DEBUG:
			logged_error.connect(_print_error)
			logged_warn.connect(_print_warn)
			logged_info.connect(_print_info)
			logged_debug.connect(_print_debug)
		LogLevel.TRACE:
			logged_error.connect(_print_error)
			logged_warn.connect(_print_warn)
			logged_info.connect(_print_info)
			logged_debug.connect(_print_debug)
			logged_trace.connect(_print_trace)


func disconnect_to_print():
	if logged_error.is_connected(_print_error):
		logged_error.disconnect(_print_error)
	if logged_warn.is_connected(_print_warn):
		logged_warn.disconnect(_print_warn)
	if logged_info.is_connected(_print_info):
		logged_info.disconnect(_print_info)
	if logged_debug.is_connected(_print_debug):
		logged_debug.disconnect(_print_debug)
	if logged_trace.is_connected(_print_trace):
		logged_trace.disconnect(_print_trace)

func change_level():
	disconnect_to_print()

	if _is_print:
		connect_to_print()

	match level:
		LogLevel.ERROR:
			_handlers[0] = _log_error
			_handlers[1] = _dummy
			_handlers[2] = _dummy
			_handlers[3] = _dummy
			_handlers[4] = _dummy
		LogLevel.WARN:
			_handlers[0] = _log_error
			_handlers[1] = _log_warn
			_handlers[2] = _dummy
			_handlers[3] = _dummy
			_handlers[4] = _dummy
		LogLevel.INFO:
			_handlers[0] = _log_error
			_handlers[1] = _log_warn
			_handlers[2] = _log_info
			_handlers[3] = _dummy
			_handlers[4] = _dummy
		LogLevel.DEBUG:
			_handlers[0] = _log_error
			_handlers[1] = _log_warn
			_handlers[2] = _log_info
			_handlers[3] = _log_debug
			_handlers[4] = _dummy
		LogLevel.TRACE:
			_handlers[0] = _log_error
			_handlers[1] = _log_warn
			_handlers[2] = _log_info
			_handlers[3] = _log_debug
			_handlers[4] = _log_trace


func _dummy(_text: String):
	pass


func log_error(text: String):
	_handlers[0].call(text)


func log_warn(text: String):
	_handlers[1].call(text)


func log_info(text: String):
	_handlers[2].call(text)


func log_debug(text: String):
	_handlers[3].call(text)


func log_trace(text: String):
	_handlers[4].call(text)


func _log_error(text: String):
	logged_error.emit(get_rich_text(text, "red"))

func _print_error(text: String):
	printerr(text)

func _log_warn(text: String):
	logged_warn.emit(get_rich_text(text, "yellow"))

func _print_warn(text: String):
	print_rich("%s" % get_rich_text(text, "yellow"))

func _log_info(text: String):
	logged_info.emit(get_rich_text(text, "green"))

func _print_info(text: String):
	print_rich("%s" % get_rich_text(text, "green"))

func _log_debug(text: String):
	logged_debug.emit(get_rich_text(text, "cyan"))

func _print_debug(text: String):
	print_rich("%s" % get_rich_text(text, "cyan"))
	

func _log_trace(text: String):
	logged_trace.emit(get_rich_text(text, "purple"))

func _print_trace(text: String):
	print_rich("%s" % get_rich_text(text, "purple"))

func get_rich_text(text: String, color: String) -> String:
	if is_rich_text:
		return "[color=%s]%s[/color]" % [color, text]
	return text


enum LogLevel {
	ERROR,
	WARN,
	INFO,
	DEBUG,
	TRACE,
}
