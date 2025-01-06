class_name DuelCharacterInfo extends ItemInfo


func set_element(character: Element):
	super.set_element(character)


# to be overriden
func refresh_element(character: Element):
	super.refresh_element(character)


func kill(state: StageState, character: Element):
	set_display_name("KILLED")
