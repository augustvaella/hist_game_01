class_name SetupResource extends Resource

var _is_setup: bool

func setup():
	if not _is_setup:
		_is_setup = true
		_setup()

# to be overriden
func _setup():
	pass
