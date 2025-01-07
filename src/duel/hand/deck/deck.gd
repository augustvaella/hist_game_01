class_name DuelDeck extends DuelCardCollector

@export var panel: Panel

func _ready():
	super._ready()
	panel.hide()


func set_state(state: DuelState):
	super.set_state(state)
	for c in state.deck.cards:
		instantiate_card(state, c)
		await get_tree().create_timer(0.01).timeout


func show_contents():
	panel.set_global_position(Vector2(100.0, 20.0))
	panel.show()


func hide_contents():
	#panel.position = Vector2(100.0, -300.0)
	panel.hide()


func toggle_visible_contents():
	if panel.visible:
		hide_contents()
	else:
		show_contents()


func draw(state: DuelState):
	if not is_exist():
		while state.stage.discard.is_exist():
			var s = state.stage.discard.salvage(state)
			add_card(state, s)
		await get_tree().create_timer(0.01).timeout

	var c = get_top()
	remove_card(state, c)

	state.stage.hand.add_card(state, c)
	await get_tree().create_timer(0.01).timeout

func add_card(state: DuelState, card: DuelCard):
	#card.scale = Vector2(0.25, 0.25)
	add_card_to_deck(state, card, state.deck)
	card.decked.emit()

func remove_card(state: DuelState, card: DuelCard):
	#card.scale = Vector2(1.0, 1.0)
	remove_card_to_deck(state, card, state.deck)
	card.removed.emit()
