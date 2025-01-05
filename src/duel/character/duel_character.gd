class_name DuelCharacter extends LinkedNode

signal changed_character(character: Character)

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

func reflesh_character():
	body.reflesh_body(character)
	info.reflesh_info(character)


# to be overriden
func _listen_character(object: Object):
	pass

func listen_character(object: Object):
	if object is Character.Changed:
		reflesh_character()	
		changed_character.emit(character)

func set_character(character: Character):
	self.character = character
	character.setup()
	character.listen_character(listen_character)
	body.set_character(character)
	info.set_character(character)
	reflesh_character()

func reset_character():
	character.cancel_listen_character(listen_character)
	

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
