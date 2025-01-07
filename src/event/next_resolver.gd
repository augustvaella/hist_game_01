class_name NextResolver extends Event
## throw it when the state will go to the next Resolver.
var _resolver: Resolver

func ini(resolver: Resolver) -> NextResolver:
	_resolver = resolver
	return self

func get_resolver() -> Resolver:
	return _resolver
