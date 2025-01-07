class_name DebugWindowHandlers extends Resource

@export var _handlers: Dictionary

# to be overriden
func set_handlers(handlers: Dictionary):
	handlers.merge(_handlers)
