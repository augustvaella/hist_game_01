class_name Chat extends Stage

func _proceed():
	var tween = get_tree().create_tween()
	tween.tween_property(get_child(0), "position", Vector2(100, 200), 3.0)
	tween.play()
	await tween.finished


func _finish():
	var tween = get_tree().create_tween()
	tween.tween_property(get_child(0), "position", Vector2(300, 300), 3.0)
	tween.play()
	await tween.finished
