class_name DuelCardHand extends DuelCardCollector

func _ready():
	super._ready()


func set_state(state: DuelState):
	super.set_state(state)
	for c in state.hand.cards:
		var dc = instantiate_card(state, c)
		add_card(state, dc)
		await get_tree().create_timer(0.01).timeout


func show_hand():
	self.visible = true

func hide_hand():
	self.visible = false


func add_card(state: DuelState, card: DuelCard):
	add_card_to_deck(state, card, state.hand)
	card.handed.emit()
	map_all(func(c): c.piled.emit())

	
func remove_card(state: DuelState, card: DuelCard):
	remove_card_to_deck(state, card, state.hand)
	card.removed.emit()
	map_all(func(c): c.unpiled.emit())
