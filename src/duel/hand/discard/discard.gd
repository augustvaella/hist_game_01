class_name DuelDiscard extends CheckableNodeCollector

func set_state(state: DuelState):
	await get_tree().create_timer(0.05).timeout
