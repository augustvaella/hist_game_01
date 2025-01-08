class_name ItemField extends LinkedNodeCollector

@export var items: Array[Item]
@export var current_item: Item

@export var item_server: ItemServer

# items needs synchronizing to the collector's. children
# -> Node.Signal

# to be overriden
func set_state(state: StageState):
	pass

# to be overriden
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


func is_index_in_bound(index: int) -> bool:
	var count = items.size()
	return index > -count and index < count


func remove_item(item: Item):
	item.reset_element()
	item_server.return_item(item)


func add_item(index: int, element: Element):
	if element:
		items[index] = item_server.get_item(element)
		add_child(items[index])
	else:
		items[index] = item_server.get_empty_item()
		add_child(items[index])

# func locate_item(index: int)
