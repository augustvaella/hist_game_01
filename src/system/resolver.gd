class_name Resolver extends Resource
## Resolver is a state in the StageState.
## Flow:
##   (StageState calls)
##   -> resolve(StageState)
##   -> on ideling to receive Event
##      ... on_input(StageState, InputEvent)
##      ... on_event(StageState, Event)


## to be overriden
func resolve(state: StageState):
	pass


# to be overriden
func on_input(state: StageState, event: InputEvent):
	pass


# to be overriden
func on_event(state: StageState, event: Event):
	pass
