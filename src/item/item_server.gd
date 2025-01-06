class_name ItemServer extends ObjectPool

@export var instance_path: String

func _ready():
	super._ready()


func _create_object() -> Object:
	return Master.master_instance_server.copy_scene(instance_path)


func get_item(element: Element) -> Item:
	var c = get_object()
	c.set_element(element)
	return c

func get_empty_item() -> Item:
	return get_object()

func return_item(item: Item):
	item.reset_element()
	return_object(item)
