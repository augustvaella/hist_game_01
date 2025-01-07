class_name DuelCardHand extends DuelCardCollector

@export var scale_card: Vector2
@export var scale_current_card: Vector2

func _ready():
	super._ready()
	changed.connect(locate_card)


func set_state(state: DuelState):
	super.set_state(state)
	for c in state.hand.cards:
		var dc = instantiate_card(state, c)
		add_card(state, dc)
		await get_tree().create_timer(0.01).timeout


func show_hand():
	self.visible = true

func hide_hand():
	self.visible = false


func add_card(state: DuelState, card: DuelCard):
	add_card_to_deck(state, card, state.hand)
	locate_card()

func remove_card(state: DuelState, card: DuelCard):
	remove_card_to_deck(state, card, state.hand)
	locate_card()

func locate_card():
	get_top().chain_post_node(func(c): c.get_card_body().scale=scale_card)
	get_top().global_position = Vector2(100, 720)
	var post = get_top().get_post_node()
	if post:
		post.chain_post_node(func(c): c.position=c.get_pre_node().position + Vector2(80, 0))
	var current = get_current_checked()
	Log.trace(current, "")
	if current:
		current.get_card_body().scale = scale_current_card
		current.position -= Vector2(0, 100)
