class_name DuelCharacter extends Node2D

@export var body: DuelCharacterBody
@export var info: DuelCharacterInfo

func set_character(character: Character):
	body.set_character(character)
	info.set_character(character)