class_name Card extends Element
## Card is a gadget in the game to the player's choice on battle.
##
## Card Whole Texture(px) 600 x 838 -> 150 x 210
## 63 x 88 (mm) 350 dpi 69.12 %

@export var display_flavor_text: String
@export var category: Category
@export var rarity: Rarity
@export var texture: Texture2D
@export var opponent_select: OpponentSelect
@export var card_select: Sacrifice
@export var challenge: Challenge

enum Category {
	PROMPT,
	DEFENSIVE,
	RESPONSIVE,
	TRICK,
	BURDEN
}

## select the opponent(s) on Challenge
enum OpponentSelect {
	NONE,
	ENEMY_SINGLE,
	ENEMY_ALL,
	FRIEND_SINGLE,
	FRIEND_ALL,
}


## the number of the Card(-s) sacreficed on use.
enum Sacrifice {
	NONE,
	SINGLE,
	DOUBLE,
	TRIPLE,
	ALL,
}

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	SUPERRARE,
	ULTRARARE,
	SECRET,
}


func try_challenge(state: StageState, challenger: Element, opponent: Element):
	challenge.challenge(state, challenger, opponent)


func get_document() -> String:
	return challenge.get_document()
