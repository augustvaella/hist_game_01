class_name FanContainer extends Container

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		var r = Rect2(Vector2(), Vector2(100, 100))
		for c in get_children():
			fit_child_in_rect(c, r)
			r.position += Vector2(100, 0)
