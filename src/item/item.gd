class_name Item extends LinkedNode
## Item is a simple Node as which Element is dealed on script.
##
## Item -> DuelCard
## Item -> DuelCharacter -> DuelActor, DuelEnemy...

signal changed_element(element: Element)

@export var element: Element
@export var info: ItemInfo


func set_element(elem: Element):
	element = elem
	element.setup()
	element.listened_object.connect(listen_object)
	info.set_element(elem)


func reset_element():
	element.listened_object.disconnect(listen_object)
	info.reset_element()
	element = null


func listen_object(object: Object):
	#print(object)
	if object is Element.Changed:
		refresh_element()
		changed_element.emit(element)
	_listen_object(object)


func refresh_element():
	info.refresh_element(element)


# to be overriden
func _listen_object(object: Object):
	pass
