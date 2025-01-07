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

static func get_category_display_name(category: Category) -> String:
	match category:
		Category.PROMPT:
			return "CARD_DISPLAY_NAME_CATEGORY_PROMPT"
		Category.DEFENSIVE:
			return "CARD_DISPLAY_NAME_CATEGORY_DEFENSIVE"
		Category.RESPONSIVE:
			return "CARD_DISPLAY_NAME_CATEGORY_RESPONSIVE"
		Category.TRICK:
			return "CARD_DISPLAY_NAME_CATEGORY_TRICK"
		Category.BURDEN:
			return "CARD_DISPLAY_NAME_CATEGORY_BURDEN"
	return ""

static func get_opponent_select_display_name(opponent_select: OpponentSelect) -> String:
	match opponent_select:
		OpponentSelect.NONE:
			return "CARD_DISPLAY_NAME_OPPONENT_SELECT_NONE"
		OpponentSelect.ENEMY_SINGLE:
			return "CARD_DISPLAY_NAME_OPPONENT_SELECT_ENEMY_SINGLE"
		OpponentSelect.ENEMY_ALL:
			return "CARD_DISPLAY_NAME_OPPONENT_SELECT_ENEMY_ALL"
		OpponentSelect.FRIEND_SINGLE:
			return "CARD_DISPLAY_NAME_OPPONENT_SELECT_FRIEND_SINGLE"
		OpponentSelect.FRIEND_ALL:
			return "CARD_DISPLAY_NAME_OPPONENT_SELECT_FRIEND_ALL"
	return ""

static func get_sacrifice_display_name(sacrifice: Sacrifice) -> String:
	match sacrifice:
		Sacrifice.NONE:
			return "CARD_DISPLAY_NAME_SACRIFICE_NONE"
		Sacrifice.SINGLE:
			return "CARD_DISPLAY_NAME_SACRIFICE_SINGLE"
		Sacrifice.DOUBLE:
			return "CARD_DISPLAY_NAME_SACRIFICE_DOUBLE"
		Sacrifice.TRIPLE:
			return "CARD_DISPLAY_NAME_SACRIFICE_TRIPLE"
		Sacrifice.ALL:
			return "CARD_DISPLAY_NAME_SACRIFICE_ALL"
	return ""

static func get_rarity_display_name(rarity: Rarity) -> String:
	match rarity:
		Rarity.COMMON:
			return "CARD_DISPLAY_NAME_RARITY_COMMON"
		Rarity.UNCOMMON:
			return "CARD_DISPLAY_NAME_RARITY_UNCOMMON"
		Rarity.RARE:
			return "CARD_DISPLAY_NAME_RARITY_RARE"
		Rarity.SUPERRARE:
			return "CARD_DISPLAY_NAME_RARITY_SUPERRARE"
		Rarity.ULTRARARE:
			return "CARD_DISPLAY_NAME_RARITY_ULTRARARE"
		Rarity.SECRET:
			return "CARD_DISPLAY_NAME_RARITY_SECRET"
	return ""

func try_challenge(state: StageState, challenger: Element, opponent: Element):
	challenge.challenge(state, challenger, opponent)


func get_document() -> String:
	return challenge.get_document()
