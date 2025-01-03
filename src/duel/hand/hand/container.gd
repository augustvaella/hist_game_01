class_name DuelCardHandFanContainer extends Container

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		var r = Rect2(Vector2(), Vector2(100, 100))
		for c in get_children():
			fit_child_in_rect(c, r)
			r.position += Vector2(100, 0)
			if c.is_checked:
				c.set_size(c.get_size() * 1.5)
			else:
				c.reset_size()


func get_checked(array: Array):
	array.assign(get_children().filter(func(c): return c.is_checked))


func get_unchecked(array: Array):
	array.assign(get_children().filter(func(c): return not c.is_checked))

func get_current_checked() -> DuelCard:
	var a = []
	get_checked(a)
	if a.size() > 0:
		return a[0]
	return null


func is_all_checked() -> bool:
	var a = []
	get_checked(a)
	if a.size() == 0:
		return false
	elif a.size() == get_child_count():
		return true
	return false


func is_exist_checked() -> bool:
	var a = []
	get_unchecked(a)
	if a.size() == 0:
		return false
	elif a.size() == get_child_count():
		return false
	return true


func check_initial():
	if not is_exist_checked():
		get_child(0).check()

		
func check_left():
	var a = []
	get_checked(a)
	if a.size() == 0:
		check_initial()
	else:
		var p = a[0].get_pre_node()
		if p:
			a.map(func(item): item.uncheck())
			p.check()


func check_right():
	var a = []
	get_checked(a)
	if a.size() == 0:
		check_initial()
	else:
		var p = a[0].get_post_node()
		if p:
			a.map(func(item): item.uncheck())
			p.check()


func check_single(index: int):
	if is_index_in_bound(index):
		var chk = get_child(index)
		get_children().map(func(c): c.check() if c == chk else c.uncheck())
		return
	Log.warn("[DuelCardHandFanContainer#%d] check_single(%d)" % [get_instance_id(), index])


func is_index_in_bound(index: int) -> bool:
	var count = get_child_count()
	return index > -count and index < count
