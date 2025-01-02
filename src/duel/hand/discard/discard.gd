class_name DuelDiscard extends Node2D

func set_state(state: DuelState):
	set_deck(state.discard)

func set_deck(deck: DiscardDeck):
	pass
