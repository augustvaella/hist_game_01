class_name DuelCharacter extends LinkedNode

@export var character: Character
@export var body: DuelCharacterBody
@export var info: DuelCharacterInfo

@export var _mark: bool
var mark: bool:
	get:
		return _mark
	set(v):
		_mark = v
		if v:
			_mark_character()
		else:
			_unmark_character()

func set_character(character: Character):
	self.character = character
	body.set_character(character)
	info.set_character(character)

func mark_character():
	mark = true

func unmark_character():
	mark = false

# to be overriden
func _mark_character():
	pass

# to be overriden
func _unmark_character():
	pass

class Empty extends DuelCharacter:
	pass
