extends Node

signal logged_error(text:String)
signal logged_warn(text:String)
signal logged_info(text:String)
signal logged_debug(text:String)
signal logged_trace(text:String)

var _level: LogLevel
var _handlers: Array[Callable]



func _ready():
	_handlers = [
		_dummy,
		_dummy,
		_dummy,
		_dummy,
		_dummy,
	]
	
	change_level(LogLevel.INFO)



func change_level(level: LogLevel):
	_level = level
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



func _dummy(_text:String):
	pass



func log_error(text:String):
	_handlers[0].call(text)



func log_warn(text:String):
	_handlers[1].call(text)



func log_info(text:String):
	_handlers[2].call(text)



func log_debug(text:String):
	_handlers[3].call(text)



func log_trace(text:String):
	_handlers[4].call(text)



func _log_error(text: String):
	printerr(text)
	logged_error.emit(text)



func _log_warn(text: String):
	print_rich("[color=yellow]%s" % text)
	logged_warn.emit(text)



func _log_info(text: String):
	print_rich("[color=green]%s" % text)
	logged_info.emit(text)



func _log_debug(text: String):
	print_rich("[color=cyan]%s" % text)
	logged_debug.emit(text)



func _log_trace(text: String):
	print_rich("[color=purple]%s" % text)
	logged_trace.emit(text)


enum LogLevel{
	ERROR,
	WARN,
	INFO,
	DEBUG,
	TRACE,
} 
