class_name Challenge extends Resource
## Challenge executes processes that challenger Character to opponent Characters.

signal challenged(challenge: Challenge)

@export var display_name: String
@export var display_document: String
@export var texture: Texture2D
@export var next_challenge: Challenge

func challenge(state: StageState, challenger: Character, opponent: Character):
	_challenge(state, challenger, opponent)
	challenged.emit(self)
	if next_challenge:
		next_challenge.challenge(state, challenger, opponent)

# to be overriden
func _challenge(state: StageState, challenger: Character, opponent: Character):
	pass


func get_document() -> String:
	var d = String(display_document)
	var n: Challenge = next_challenge
	while n:
		d = "%s %s" % [d, n.display_document]
		n = n.next_challenge
	return d
