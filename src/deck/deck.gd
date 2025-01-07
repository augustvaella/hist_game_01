class_name Deck extends Resource

@export var cards: Array[Card]

func push_back_card(card: Card):
	cards.push_back(card)


func push_front_card(card: Card):
	cards.push_front(card)

func insert_card(card: Card, index: int):
	if _is_index_in_bound(index):
		cards.insert(index, card)
		return
	Log.error(self, "couldn't insert_card(%s, %d)" % \
		[index, card])


func erase_card(card: Card):
	cards.erase(card)


func pop_front_card() -> Card:
	return cards.pop_front()


func pop_back_card() -> Card:
	return cards.pop_back()


func pick_random_card() -> Card:
	return cards.pick_random()


func pop_at_card(index: int) -> Card:
	if _is_index_in_bound(index):
		return cards.pop_at(index)
	Log.error(self, "couldn't pick_card(%d)" % \
		[index])
	return null

# Callable<Card> -> bool
func pop_all_conditional_card(callable: Callable, result: Array):
	var s: Array[Card] = []
	for i in range(cards.size()):
		var c = cards[i]
		if callable.call(c):
			result.append(c)
		else:
			s.append(c)
	cards.clear()
	cards.assign(s)


func pop_all_card(result: Array):
	result.assign(cards)
	cards.clear()


func shuffle_card():
	cards.shuffle()


func clear_card():
	cards.clear()


func _is_index_in_bound(index: int) -> bool:
	if index > -cards.size() and index < cards.size():
		return true
	Log.warn(self, "index out of bound" % [])
	return false


func switch_card(from: int, to: int):
	if _is_index_in_bound(from) and _is_index_in_bound(to):
		var c = cards[to]
		cards[to] = cards[from]
		cards[from] = c
	Log.error(self, "couldn't switch_card(%d, %d)" % \
		 [from, to])


# Callcable<Card> -> bool
func is_contains(callable: Callable) -> bool:
	for c in cards:
		if callable.call(c):
			return true
	return false
