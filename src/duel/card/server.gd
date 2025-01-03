class_name DuelCardServer extends ObjectPool

func _ready():
	super._ready()


func _create_object() -> Object:
	return Master.master_instance_server.copy_scene("res://src/duel/card/card.tscn")


func get_card(card: Card) -> DuelCard:
	var c = get_object()
	c.set_card(card) 
	return c


func return_card(card: DuelCard):
	return_object(card)
