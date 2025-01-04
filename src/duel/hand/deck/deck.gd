class_name DuelDeck extends DuelCardCollector

func set_state(state: DuelState):
	super.set_state(state)
	for c in state.deck.cards:
		instantiate_card(state, c)
		await get_tree().create_timer(0.01).timeout


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
	add_card_to_deck(state, card, state.deck)

func remove_card(state: DuelState, card: DuelCard):
	remove_card_to_deck(state, card, state.deck)
