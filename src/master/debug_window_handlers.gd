class_name GameDebugWindowHandlers extends DebugWindowHandlers

func set_handlers(handlers: Dictionary):
	var d = {
		"echo": func(debug: DebugWindow, state: StageState, args: PackedStringArray): debug.show_label(args[0]),
		"deck": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_deck(debug, state, ),
		"hand": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_hand(debug, state, ),
		"discard": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_duel_discard(debug, state, ),
		"foe": func(debug: DebugWindow, state: StageState, args: PackedStringArray): show_foe(debug, state, ),
		"all": func(debug: DebugWindow, state: StageState, args: PackedStringArray): instance_list(debug, state, ),
	}
	_handlers.merge(d)
	super.set_handlers(handlers)

func show_duel_deck(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		debug.show_label(var_to_str(state.deck.cards))

func show_duel_hand(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		debug.show_label(var_to_str(state.hand.cards))

func show_duel_discard(debug: DebugWindow, state: StageState, ):
	if state is DuelState:
		debug.show_label(var_to_str(state.discard.cards))

func show_foe(debug: DebugWindow, state: StageState, ):
	var t = ""
	if state is DuelState:
		var r = []
		var v = []
		var d = []
		state.foe_party.get_reserves(r)
		state.foe_party.get_vitals(v)
		state.foe_party.get_deads(d)
		debug.show_label("foe: Re:%s\nVi:%sDe:%s" % [ \
			r, v, d])

func instance_list(debug: DebugWindow, state: StageState, ):
	debug.show_label("instances:")
