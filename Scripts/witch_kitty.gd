extends Node2D

var anim = ""
var new_anim = ""

enum { KITTY_IDLE, KITTY_LICK, KITTY_LAYDOWN, KITTY_SLEEP, KITTY_ITCH, KITTY_TALK }

var kitty_state = KITTY_IDLE
var kitty_talkie_counter = 0


	

@onready var interaction_area: InteractionArea = $WKInteractionArea


func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals
	
	
	
	match kitty_state:
		KITTY_IDLE:
			new_anim = "idle"
		
	
	if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
	pass

func DialogicSignalEvent(argument:String):
	if argument == "KittyTalkieCounter":
		kitty_talkie_counter += 1
	pass

func _on_interact():
	var update_item = get_node("/root/InteractionManager")
	if kitty_talkie_counter == 0:
		Dialogic.start("res://Dialogue/KittyExplain1.dtl")
		await Dialogic.timeline_ended
		return
	
	if kitty_talkie_counter == 1 && update_item.has_item == false:
		Dialogic.start("res://Dialogue/LotusReminder.dtl")
		await Dialogic.timeline_ended
		return
	
	if kitty_talkie_counter == 1 && update_item.has_item == true:
		Dialogic.start("res://Dialogue/DaffodilStart.dtl")
		await Dialogic.timeline_ended
		update_item.has_item = false
		return
		
	if kitty_talkie_counter == 2 && update_item.has_item == false:
		Dialogic.start("res://Dialogue/DaffodilReminder.dtl")
		await Dialogic.timeline_ended
		return
	if kitty_talkie_counter == 2 && update_item.has_item == true:
		Dialogic.start("res://Dialogue/ShellStart.dtl")
		await Dialogic.timeline_ended
		update_item.has_item = false
		return
		
	if kitty_talkie_counter == 3 && update_item.has_item == false:
		Dialogic.start("res://Dialogue/ShellReminder.dtl")
		await Dialogic.timeline_ended
		return
	if kitty_talkie_counter == 3 && update_item.has_item == true:
		Dialogic.start("res://Dialogue/BerryStart.dtl")
		await Dialogic.timeline_ended
		update_item.has_item = false
		return
		
	if kitty_talkie_counter == 4 && update_item.has_item == false:
		Dialogic.start("res://Dialogue/BerryReminder.dtl")
		await Dialogic.timeline_ended
		return
	if kitty_talkie_counter == 4 && update_item.has_item == true:
		Dialogic.start("res://Dialogue/StarStart.dtl")
		await Dialogic.timeline_ended
		update_item.has_item = false
		return
		
	if kitty_talkie_counter == 5 && update_item.has_item == false:
		Dialogic.start("res://Dialogue/StarReminder.dtl")
		await Dialogic.timeline_ended
		return
	if kitty_talkie_counter == 5 && update_item.has_item == true:
		Dialogic.start("res://Dialogue/GameEnd.dtl")
		await Dialogic.timeline_ended
		update_item.has_item = false
		return
		
	if kitty_talkie_counter == 6:
		Dialogic.start("res://Dialogue/GameEndReRun.dtl")
		await Dialogic.timeline_ended
		return


	else:
		print("I have been interacted with... but I have no dialogue to give")
		pass

