class_name LinkedNode extends CheckableNode
## Linked Node knows the pre- and post-positioned sibling Node.

func _ready():
	super._ready()

func get_pre_node() -> Node:
	var index = get_index()
	if index == 0:
		return null
	return get_parent().get_child(index - 1)

func get_post_node() -> Node:
	var index = get_index()
	var count = get_parent().get_child_count()
	if count == 1:
		return null
	elif index == count - 1:
		return null
	return get_parent().get_child(index + 1)


func is_index_in_bound(index: int) -> bool:
	var count = get_parent().get_child_count()
	return index > -count and index < count


func get_sibling_node(index: int) -> Node:
	if is_index_in_bound(index):
		return get_parent().get_child(index)
	return null


## callable: Callable<LinkedNode>
func chain_post_node(callable: Callable):
	callable.call(self)
	var n = get_post_node()
	if n:
		n.chain_post_node(callable)


## callable: Callable<LinkedNode>
func chain_pre_node(callable: Callable):
	callable.call(self)
	var n = get_pre_node()
	if n:
		n.chain_pre_node(callable)
