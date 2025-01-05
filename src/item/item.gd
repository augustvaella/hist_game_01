class_name Item extends LinkedNode
## Item is a simple Node

signal changed_element(element: Element)

@export var element: Element
@export var info: ItemInfo


func set_element(elem: Element):
	element = elem
	info.set_element(elem)


func reset_element():
	element.listened_object.disconnect(listen_object)
	info.reset_element()


func listen_object(object: Object):
	if object is Element.Changed:
		reflesh_element()
		changed_element.emit(element)
	_listen_object(object)


func reflesh_element():
	info.reflesh_element(element)


# to be overriden
func _listen_object(object: Object):
	pass
