class_name DuelDeck extends Node2D

var _deck: Array[DuelCard]

func set_state(state: DuelState):
	set_deck(state.deck)


func set_deck(deck: PlayerDeck):
	_deck.clear()
	for d in deck.cards:
		var c = Master.master_instance_server.copy_scene("res://src/duel/card/card.tscn")
		c.set_card(d)
		_deck.push_back(c)


func draw() -> DuelCard:
	return _deck.pop_back()
