class_name DebugWindow extends Window

@export var label_upper: RichTextLabel
@export var label_lower: RichTextLabel
@export var line_edit: LineEdit

var _handlers: Dictionary
func _ready():
	Log.logged_error.connect(func(text:String): show_label_lower(text))
	Log.logged_warn.connect(func(text:String): show_label_lower(text))
	Log.logged_info.connect(func(text:String): show_label_lower(text))
	Log.logged_debug.connect(func(text:String): show_label_lower(text))
	Log.logged_trace.connect(func(text:String): show_label_lower(text))
	set_handlers()
	show()

func show_label_upper(text: String):
	label_upper.text = "%s\n%s" % [label_upper.text, text]

func show_label_lower(text: String):
	label_lower.text = "%s\n%s" % [label_lower.text, text]

func set_handlers():
	_handlers = {
		"print": func(text: String): show_label_lower(text),
	}
