class_name DuelResolver extends Resolver

func next_resolver(state: StageState, resolver_name: String):
	state.stage_emit_listened_event(Event.NextResolver.new(state.resolvers[resolver_name]))
