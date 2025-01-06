class_name DuelCardCollector extends CheckableNodeCollector

@export var deck: Deck

func set_state(state: DuelState):
	pass


func instantiate_card(state: DuelState, card: Card):
	var c = state.stage.card_server.get_card(card)
	add_node(c)

func return_card(state: DuelState, card: DuelCard):
	remove_node(card)
	state.stage.card_server.return_card(card)

func add_card_to_deck(state: DuelState, card: DuelCard, deck: Deck):
	deck.push_back_card(card.element)
	add_node(card)


func remove_card_to_deck(state: DuelState, card: DuelCard, deck: Deck):
	deck.erase_card(card.element)
	remove_node(card)
