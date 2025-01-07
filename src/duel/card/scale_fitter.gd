class_name DuelCardScaleFitter extends Node

@export var texture: TextureRect
@export var scale_current_hand:Vector2
@export var scale_hand:Vector2

func fit_scale_current_hand():
	texture.scale = scale_current_hand

func fit_scale_hand():
	texture.scale = scale_hand
	
