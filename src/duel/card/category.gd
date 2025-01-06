class_name DuelCardCategory extends TextureRect

@export var textures: Array[Texture2D] #Card.Category
# PROMPT = 0, DEFENSIVE = 1, RESPONSIVE = 2, TRICK = 3, BURDEN = 4

func set_element(element: Element):
	texture = textures[element.category]
