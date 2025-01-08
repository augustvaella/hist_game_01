class_name LinkedNodeCollector extends Node
## LinkedNodeCollector deals LinkedNode to govern checking.

signal changed

@export var is_checkable: bool

## the pointer to the Node contains CheckableNode
## if null to pointing self
@export var collector: Node

@export var mode: Mode

## Checking rule mode
enum Mode {
	SINGLE, ## one Node be checked and able to change checking
	ALL, ## all Node be checked and disable to change checking
}

func mode_single():
	mode = Mode.SINGLE

func mode_all():
	mode = Mode.ALL
	
func _ready():
	if not collector:
		collector = self

func enable_checkable():
	is_checkable = true
	check_initial()


func disable_checkable():
	is_checkable = false
	uncheck_all()

## callable: Callable<LinkedNode>
func map_all(callable: Callable):
	collector.get_children().map(callable)


func get_all(array: Array):
	array.assign(collector.get_children())


func get_count() -> int:
	return collector.get_child_count()


func get_all_checked(array: Array):
	array.assign(collector.get_children().filter(func(c): return c.is_checked))


func get_all_unchecked(array: Array):
	array.assign(collector.get_children().filter(func(c): return not c.is_checked))


func get_current_checked() -> CheckableNode:
	var a = []
	get_all_checked(a)
	if a.size() > 0:
		return a[0]
	return null


func get_top() -> Node:
	if collector.get_child_count() > 0:
		return collector.get_child(0)
	return null


func is_exist() -> bool:
	return collector.get_child_count() > 0


func is_all_checked() -> bool:
	var a = []
	get_all_checked(a)
	if a.size() == 0:
		return false
	elif a.size() == collector.get_child_count():
		return true
	return false


func is_exist_checked() -> bool:
	var a = []
	get_all_unchecked(a)
	if a.size() == 0:
		return false
	elif a.size() == collector.get_child_count():
		return false
	return true


func check_initial():
	if mode == Mode.ALL:
		return
	var p = collector.get_child(0)
	while p:
		if p.is_checkable():
			p.check()
			return
		p = p.get_post_node()

		
func check_left():
	if mode == Mode.ALL:
		return
	var a = []
	get_all_checked(a)
	if a.size() == 0:
		check_initial()
	else:
		var p = a[0].get_pre_node()
		while p and not p.is_checkable():
			p = p.get_pre_node()
		if p:
			a.map(func(item): item.uncheck())
			p.check()


func check_right():
	if mode == Mode.ALL:
		return
	var a = []
	get_all_checked(a)
	if a.size() == 0:
		check_initial()
	else:
		var p = a[0].get_post_node()
		while p and not p.is_checkable():
			p = p.get_post_node()
		if p:
			a.map(func(item): item.uncheck())
			p.check()


func check_single(index: int):
	if mode == Mode.ALL:
		return
	if is_index_in_bound(index):
		var chk = collector.get_child(index)
		if chk:
			chk.check()
		return
	Log.warn(self, "check_single(%d)" % [index])


func check_at(index: int):
	if mode == Mode.ALL:
		return
	if is_index_in_bound(index):
		var chk = collector.get_child(index)
		collector.get_children().map(func(c): c.check() if c == chk else c.uncheck())
		return
	Log.warn(self, "check_at(%d)" % [index])


func uncheck_single(index: int):
	if mode == Mode.ALL:
		return
	if is_index_in_bound(index):
		var chk = collector.get_child(index)
		collector.get_children().map(func(c): c.uncheck() if c == chk else c.check())
		return
	Log.warn(self, "uncheck_single(%d)" % [index])


func uncheck_at(index: int):
	if mode == Mode.ALL:
		return
	if is_index_in_bound(index):
		var chk = collector.get_child(index)
		if chk:
			chk.uncheck()
		return
	Log.warn(self, "uncheck_at(%d)" % [index])


func check_all():
	if mode == Mode.SINGLE:
		return
	collector.get_children().map(func(item): item.check())


func uncheck_all():
	collector.get_children().map(func(item): item.uncheck())


func is_index_in_bound(index: int) -> bool:
	var count = collector.get_child_count()
	return index > -count and index < count


func add_node(node: CheckableNode):
	collector.add_child(node)
	node.changed.connect(emit_changed)


func remove_node(node: CheckableNode):
	collector.remove_child(node)
	node.changed.disconnect(emit_changed)


func emit_changed():
	changed.emit()
