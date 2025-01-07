class_name GameDebugWindowHandlers extends DebugWindowHandlers

func set_handlers(handlers: Dictionary):
	var d = {
		"echo": func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.show_label(args[0]),
		"deck": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_deck(debug, state, ),
		"hand": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_hand(debug, state, ),
		"discard": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_discard(debug, state, ),
		"friend": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_friend(debug, state, ),
		"foe": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_foe(debug, state, ),
		"state": func(debug: DebugWindow, state: StageState, args: PackedStringArray): instance_list(debug, state, ),
	}
	_handlers.merge(d)
	super.set_handlers(handlers)

func show_duel_deck(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		var s = state.deck.cards
		debug.show_label("%s%s" % [get_name_id(state.deck), s])

func show_duel_hand(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		var s = state.hand.cards
		debug.show_label("%s%s" % [get_name_id(state.hand), s])

func show_duel_discard(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		var s = state.discard.cards
		debug.show_label("%s%s" % [get_name_id(state.discard), s])

func show_foe(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		var r = []
		var v = []
		var d = []
		state.foe_party.get_reserves(r)
		state.foe_party.get_vitals(v)
		state.foe_party.get_deads(d)
		debug.show_label("%s R%s V%s D%s" % [ \
			get_name_id(state.foe_party), r, v, d])


func show_friend(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		var r = []
		var v = []
		var d = []
		state.friend_party.get_reserves(r)
		state.friend_party.get_vitals(v)
		state.friend_party.get_deads(d)
		debug.show_label("%s R%s V%s D%s" % [ \
			get_name_id(state.friend_party), r, v, d])


func instance_list(debug: DebugWindow, state: StageState, ):
	debug.show_label("[%s]" % [get_name_id(state)])
	if state is DuelState:
		show_friend(debug, state)
		show_duel_deck(debug, state)
		show_duel_hand(debug, state)
		show_duel_discard(debug, state)
		show_foe(debug, state)


func get_name_id(object: Variant) -> String:
	return Log.gd(object)
