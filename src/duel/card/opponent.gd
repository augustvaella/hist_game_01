class_name DuelCardOpponent extends TextureRect

@export var textures: Array[Texture2D] # Card.OpponentSelect
# None = 0, ENEMY_SINGLE = 1, ENEMY_ALL = 2, FRIEND_SINGLE = 3, FRIEND_ALL = 4

@export var label: Label

func set_element(element: Element):
		texture = textures[element.opponent_select]
		label.text = "%d" % element.card_select
