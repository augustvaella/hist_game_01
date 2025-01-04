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
