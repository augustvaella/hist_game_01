class_name ItemInfo extends Control

@export var display_name: Label

func set_display_name(text: String):
	display_name.text = text


func set_element(element: Element):
	set_display_name(element.display_name)


func reset_element():
	display_name.text = String()


func reflesh_element(element: Element):
	set_display_name(element.display_name)
