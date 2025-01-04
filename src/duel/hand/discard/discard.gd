class_name DuelDiscard extends DuelCardCollector

func set_state(state: DuelState):
	super.set_state(state)
	for c in state.discard.cards:
		var dc = instantiate_card(state, c)
		add_card(state, dc)
		await get_tree().create_timer(0.01).timeout

func discard(state: DuelState, card: DuelCard):
	state.stage.hand.remove_card(state, card)
	add_card(state, card)
	await get_tree().create_timer(0.01).timeout

func salvage(state: DuelState) -> DuelCard:
	var c = get_top()
	if c:
		remove_card(state, c)
		return c
	return null


func add_card(state: DuelState, card: DuelCard):
	add_card_to_deck(state, card, state.discard)

func remove_card(state: DuelState, card: DuelCard):
	remove_card_to_deck(state, card, state.discard)
