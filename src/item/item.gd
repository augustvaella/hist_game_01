class_name Item extends LinkedNode
## Item is a simple Node to be able to set without StageState

@export var element: Element
@export var info: ItemInfo

func set_element(elem: Element):
	element = elem
	info.set_element(elem)

func reset_element():
	info.reset_element()
