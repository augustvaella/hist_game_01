class_name DuelNextResolverEvent extends DuelEvent

var _resolver: DuelResolver

func _init(resolver: DuelResolver):
	_resolver = resolver


func get_resolver() -> DuelResolver:
	return _resolver
