class_name ItemField extends CheckableNodeCollector

@export var items: Array[Item]
@export var current_item: Item

@export var item_server: ItemServer

func set_state(state: StageState):
	pass


func reset_state():
	pass

func unmark_all_items():
	pass


func mark_current_item():
	items.map(func(item): item.mark() if item == current_item else item.unmark())


func reset_current_item():
	current_item = null
	unmark_all_items()

func get_init_item() -> Item:
	current_item = items[0]
	mark_current_item()
	return current_item

func next_current_item() -> Item:
	if not current_item:
		return get_init_item()

	var next_index = items.find(current_item) + 1
	if next_index > 0 and next_index < items.size():
		current_item = items[next_index]
		mark_current_item()
		return current_item

	reset_current_item()
	return current_item


func set_elements(elements: Array):
	var elm = []
	elm.assign(elements)
	for item in items.filter(func(i): return i.element == null):
		var e = elm.pop_front()
		if e:
			item.set_element(e)


func is_index_in_bound(index: int) -> bool:
	var count = items.size()
	return index > -count and index < count


func reset_elements():
	items.map(func(item): item.reset_element())

func remove_item(item: Item):
	item.reset_element()
	item_server.return_item(item)
