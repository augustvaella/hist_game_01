class_name DuelFieldBackground extends Node2D

@export var sprite: Sprite2D

func set_state(state: StageState):
	sprite.texture = state.field.background_texture
