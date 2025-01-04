class_name Card extends Resource
@export var display_name: String
@export var texture: Texture2D
@export var opponent_select: OpponentSelect
@export var card_select: CardSelect
@export var challenge: Challenge

enum OpponentSelect {
	NONE,
	ENEMY_SINGLE,
	ENEMY_ALL,
	FRIEND_SINGLE,
	FRIEND_ALL,
}

enum CardSelect {
	NONE,
	SINGLE,
	DOUBLE,
	TRIPLE,
	ALL,
}

func try_challenge(state: StageState, challenger: Character, opponent: Character):
	challenge.challenge(state, challenger, opponent)
