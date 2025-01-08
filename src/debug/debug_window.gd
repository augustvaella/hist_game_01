class_name DebugWindow extends Window
## self-made debugging tool
##

@export var init_position: Vector2
@export var label: RichTextLabel
@export var line_edit: LineEdit
@export var handlers: DebugWindowHandlers

var _integer: RegEx
var _splitter: RegEx
var _erasetag: RegEx

var _handlers: Dictionary

var _startup: Startup

func _ready():
	position = init_position
	Log.logged_error.connect(func(text: String): show_label(text))
	Log.logged_warn.connect(func(text: String): show_label(text))
	Log.logged_info.connect(func(text: String): show_label(text))
	Log.logged_debug.connect(func(text: String): show_label(text))
	Log.logged_trace.connect(func(text: String): show_label(text))

	_integer = RegEx.new()
	_integer.compile("[-0-9]+")

	_splitter = RegEx.new()
	_splitter.compile("(\"[^\"]*\")|[^\\s+]+")

	_erasetag = RegEx.new()
	_erasetag.compile("\\[color=[a-zA-Z0-9_\"\']+\\](.*)\\[/color\\]")

	_handlers = {}
	_handlers["echo"] = func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.show_label(args[0])
	_handlers["clear"] = func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.clear_label()
	_handlers["save"] = func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.save_label_text()
	_handlers["CRASHCRASHCRASH"] = func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.crash()
	#_handlers["#"] = func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.show_label(gdi(args[0]))

	if handlers:
		handlers.set_handlers(_handlers)
	
	show()
	Master.get_tree().root.grab_focus()
	
func set_startup(startup: Startup):
	_startup = startup


func crash():
	Log.error(self, "INTENTIONALLY Godot OS.crash() is called.")
	OS.crash("Godot OS.crash() called.")


func save_label_text():
	var d = Time.get_datetime_dict_from_system()
	var filename = "%d_%02d%02d_%02d%02d%02d.log" % [d.year, d.month, d.day, d.hour, d.minute, d.second]
	var file = FileAccess.open("user://%s" % [filename], FileAccess.WRITE)
	var txt = _erasetag.sub(label.text, "$1", true)
	file.store_string(txt)
	show_label("saved user://%s" % [filename])


func show_label(text: String):
	label.text = "%s\n<%s> %s" % [label.text, Time.get_datetime_string_from_system(), text]

func clear_line_edit():
	line_edit.text = String()

func input_line_edit():
	var ins = _integer.search(line_edit.text)
	if ins:
		show_label(gdi(ins.get_string()))
		clear_line_edit()
		return
		
	var elm = []
	parse_line(line_edit.text, elm)
	#for e in elm:
	#	show_label(e)
	if elm.size() > 0 and _handlers.has(elm[0]):
		_handlers[elm[0]].call(self, get_stage_state(), elm.slice(1, elm.size()))
	clear_line_edit()
	

func _input(event: InputEvent):
	if event.is_action_pressed("DebugEnter"):
		input_line_edit()
	elif event.is_action_pressed("DebugSave"):
		save_label_text()

func clear_label():
	label.text = ""

func parse_line(line: String, result: Array):
	for r in _splitter.search_all(line):
		result.push_back(r.get_string())


func _process(delta: float):
	if not _startup or _startup.get_child_count() == 0:
		return
	var stage = _startup.get_current_stage()
	show_stage_state(stage._state)

func get_stage() -> Stage:
	return _startup.get_current_stage()


func show_stage_state(state: StageState):
	#show_label_upper(var_to_str(state.get_property_list()))
	pass

func get_stage_state() -> StageState:
	if not _startup or _startup.get_child_count() == 0:
		return null
	return _startup.get_current_stage()._state

func gdi(id: String) -> String:
	var i = id.to_int()
	var ins = instance_from_id(i)
	if ins:
		if ins is Resource:
			return "%s[%s](%s)" % [gd(ins), ins.resource_name, ins.resource_path]
		elif ins is Node:
			return "%s[%s](%s)" % [gd(ins), ins.name, ins.get_path()]
		return gd(ins)
	return "null"

func gd(variant: Variant) -> String:
	if variant:
		if variant is Object:
			return "%s#%d" % [variant.get_script().get_global_name(), variant.get_instance_id()]
		return variant.to_string()
	return "null"
