class_name Test extends Stage

@export var sprites: Array[Sprite2D]
var sprite_index: int = 0

@export var label: RichTextLabel

func _ready():
	Loading.hide()
	
	# ResourceServer
	Master.resource_server.loaded_resource.connect(on_load_test_resource)
	Master.resource_server.request_load_resource_set("res://test/assets/test_resource_0.tres")
	Master.resource_server.request_load_resource_set("res://test/assets/test_resource_1.tres")
	Master.resource_server.request_load_resource_set("res://test/assets/test_resource_2.tres")

func write_label(text: String):
	label.text = "%s\n%s" % [label.text, text]


func on_load_test_resource(resource: Resource):
	if resource is TestResource:
		set_texture_to_sprite(resource.sprite)
		write_label(resource.text)


func set_texture_to_sprite(texture: Texture2D):
	sprites[sprite_index].texture = texture
	sprite_index += 1
