class_name DuelCharacterBody extends Node2D
@export var sprite: Sprite2D


func set_element(character: Element):
	sprite.texture = character.duel_texture


# to be overriden
func reflesh_element(character: Element):
	pass
