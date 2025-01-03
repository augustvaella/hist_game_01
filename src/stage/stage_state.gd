class_name StageState extends Resource

# resolver
@export var initial_resolver: DuelResolver
@export var resolvers: Dictionary # Dictionary<String, DuelResolver>
@export var current_resolver: DuelResolver

@export var register: Dictionary
@export var event_queue: Array[Event]

var stage: Stage


func set_stage(stage: Stage):
	self.stage = stage


func get_stage() -> Stage:
	return stage


# to be overriden
func get_stage_name() -> String:
	return String()


# to be overriden
func get_next_stage_state() -> StageState:
	return null

func stage_emit_listened_event(event: Event):
	stage.listened_event.emit(event)


func _on_input(event: Event):
	current_resolver.on_input(self, event.get_input_event())


func _on_event(event: Event):
	current_resolver.on_event(self, event)


func event_loop():
	while true:
		while event_queue.size() > 0:
			var event = event_queue.pop_front()
			if event is Event.Finish:
				return null
			elif event is Event.NextResolver:
				return event.get_resolver()
			elif event is Event.StageInput:
				_on_input(event)
			else:
				_on_event(event)

		await stage.get_tree().process_frame


func resolve_stage():
	current_resolver = initial_resolver
	while current_resolver:
		current_resolver.resolve(self)
		current_resolver = await event_loop()
		print(current_resolver)


	Master.get_startup().change_stage(get_next_stage_state())
