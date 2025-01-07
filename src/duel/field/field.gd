class_name DuelField extends Node2D

@export var background: DuelFieldBackground

func set_state(state: StageState):
	background.set_state(state)
