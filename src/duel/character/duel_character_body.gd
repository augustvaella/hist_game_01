class_name DuelCharacterBody extends Node2D
@export var sprite: Sprite2D


func set_element(character: Element):
	sprite.texture = character.duel_texture


# to be overriden
func refresh_element(character: Element):
	pass


func kill(state: StageState, character: Element):
	sprite.modulate = Color(0.0, 0.0, 0.0, 1.0)
