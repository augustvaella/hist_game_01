class_name DuelCharacter extends LinkedNode

@export var character: Character
@export var body: DuelCharacterBody
@export var info: DuelCharacterInfo


func set_character(character: Character):
	self.character = character
	body.set_character(character)
	info.set_character(character)
