class_name SetupResource extends Resource
## SetupResource is used when once setup is needed.
##
## SetupResource.setup() should be called on using the Resource
## because of avoiding no setup() called glitch.

## setup() guard
var _is_setup: bool

func setup():
	if not _is_setup:
		_is_setup = true
		_setup()

# to be overriden
func _setup():
	pass
