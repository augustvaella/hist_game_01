class_name DebugWindow extends Window
## self-made debugging tool
##

@export var init_position: Vector2
@export var label: RichTextLabel
@export var line_edit: LineEdit

var _splitter: RegEx
var _handlers: Dictionary

var _startup: Startup

func _ready():
	position = init_position
	Log.logged_error.connect(func(text: String): show_label(text))
	Log.logged_warn.connect(func(text: String): show_label(text))
	Log.logged_info.connect(func(text: String): show_label(text))
	Log.logged_debug.connect(func(text: String): show_label(text))
	Log.logged_trace.connect(func(text: String): show_label(text))

	_splitter = RegEx.new()
	_splitter.compile("(\"[^\"]*\")|[^\\s+]+")
	set_handlers()
	
	show()
	Master.get_tree().root.grab_focus()
	
func set_startup(startup: Startup):
	_startup = startup


func show_label(text: String):
	label.text = "%s\n%s" % [label.text, text]

func clear_line_edit():
	line_edit.text = String()

func input_line_edit():
	var elm = []
	parse_line(line_edit.text, elm)
	#for e in elm:
	#	show_label(e)
	if elm.size() > 0 and _handlers.has(elm[0]):
		_handlers[elm[0]].call(elm.slice(1, elm.size()))
	clear_line_edit()
	

func set_handlers():
	_handlers = {
		"echo": func(args: PackedStringArray): show_label(args[0]),
		"deck": func(args: PackedStringArray): show_duel_deck(),
		"hand": func(args: PackedStringArray): show_duel_hand(),
		"discard": func(args: PackedStringArray): show_duel_discard(),
		"foe": func(args: PackedStringArray): show_foe(),
		"all": func(args: PackedStringArray): instance_list(),
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

func get_stage() -> Stage:
	return _startup.get_current_stage()


func show_stage_state(state: StageState):
	#show_label_upper(var_to_str(state.get_property_list()))
	pass

func get_stage_state() -> StageState:
	if not _startup or _startup.get_child_count() == 0:
		return null
	return _startup.get_current_stage()._state
	
func show_duel_deck():
	var s = get_stage_state()
	if s and s is DuelState:
		show_label(var_to_str(s.deck.cards))

func show_duel_hand():
	var s = get_stage_state()
	if s and s is DuelState:
		show_label(var_to_str(s.hand.cards))

func show_duel_discard():
	var s = get_stage_state()
	if s and s is DuelState:
		show_label(var_to_str(s.discard.cards))

func show_foe():
	var s = get_stage_state()
	var t = ""
	if s and s is DuelState:
		var r = []
		var v = []
		var d = []
		s.foe_party.get_reserves(r)
		s.foe_party.get_vitals(v)
		s.foe_party.get_deads(d)
		show_label("foe: Re:%s\nVi:%sDe:%s" % [ \
			r, v, d])

func instance_list():
	show_label("instances:")
