class_name DuelCharacterBody extends Node2D
@export var sprite: Sprite2D

func set_character(character: Character):
	sprite.texture = character.duel_texture

# to be overriden
func reflesh_body(character: Character):
	pass
