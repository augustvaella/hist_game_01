class_name DebugWindow extends Window

@export var label_upper: RichTextLabel
@export var label_lower: RichTextLabel
@export var line_edit: LineEdit

var _splitter: RegEx
var _handlers: Dictionary

var _startup: Startup

func _ready():
	Log.logged_error.connect(func(text:String): show_label_lower(text))
	Log.logged_warn.connect(func(text:String): show_label_lower(text))
	Log.logged_info.connect(func(text:String): show_label_lower(text))
	Log.logged_debug.connect(func(text:String): show_label_lower(text))
	Log.logged_trace.connect(func(text:String): show_label_lower(text))

	_splitter = RegEx.new()
	_splitter.compile("(\"[^\"]*\")|[^\\s+]+")
	set_handlers()
	
	show()
	
func set_startup(startup: Startup):
	_startup = startup

func show_label_upper(text: String):
	label_upper.text = text

func show_label_lower(text: String):
	label_lower.text = "%s\n%s" % [label_lower.text, text]

func clear_line_edit():
	line_edit.text = String()

func input_line_edit():
	var elm = []
	parse_line(line_edit.text, elm)
	#for e in elm:
	#	show_label_lower(e)
	if elm.size() > 0 and _handlers.has(elm[0]):
		_handlers[elm[0]].call(elm.slice(1, elm.size()))
	clear_line_edit()
	

func set_handlers():
	_handlers = {
		"echo": func(args: PackedStringArray): show_label_lower(args[0]),
	}

func _input(event: InputEvent):
	if event.is_action_pressed("DebugEnter"):
		input_line_edit()


func parse_line(line: String, result: Array):
	for r in _splitter.search_all(line):
		result.push_back(r.get_string())


func _process(delta: float):
	if not _startup or _startup.get_child_count() == 0:
		return
	var stage = _startup.get_current_stage()
	show_stage_state(stage._state)


func show_stage_state(state: StageState):
	#show_label_upper(var_to_str(state.get_property_list()))
	pass
