class_name DuelDeck extends CheckableNodeCollector

func set_state(state: DuelState):
	for c in state.deck.cards:
		var dc = state.stage.card_server.get_card(c)
		add_node(dc)
		await get_tree().create_timer(0.01).timeout


func draw(state: DuelState):
	if not is_exist():
		pass
	var c = get_top()
	state.deck.erase_card(c.card)
	state.stage.hand.add_node(c)
	state.hand.push_back_card(c.card)
	await get_tree().create_timer(0.01).timeout
