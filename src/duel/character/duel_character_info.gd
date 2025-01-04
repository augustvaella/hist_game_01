class_name DuelCharacterInfo extends Control
@export var display_name: Label

func set_character(character: Character):
	display_name.text = character.display_name
