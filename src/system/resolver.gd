class_name Resolver extends Resource

# to be overriden
func resolve(state: StageState):
	pass


# to be overriden
func on_input(state: StageState, event: InputEvent):
	pass


# to be overriden
func on_event(state: StageState, event: Event):
	pass
