class_name DuelDeck extends Node2D

func set_state(state: DuelState):
	await get_tree().create_timer(0.05).timeout


func set_deck(deck: PlayerDeck):
	pass


func draw(state: DuelState) -> DuelCard:
	var rc = state.draw_card_from_deck()
	if rc:
		var c = state._duel.card_server.get_card(rc)
		return c
	return null
