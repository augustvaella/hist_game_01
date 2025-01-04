class_name DuelCardHand extends CheckableNodeCollector


func set_state(state: DuelState):
	await get_tree().create_timer(0.05).timeout


func show_hand():
	self.visible = true

func hide_hand():
	self.visible = false
