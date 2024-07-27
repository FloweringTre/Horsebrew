extends Node2D

var anim = ""
var new_anim = ""

enum { KITTY_IDLE, KITTY_LICK_PAW, KITTY_LICK_FUR, KITTY_LOOK, KITTY_MAD }

var kitty_state = KITTY_IDLE
var kitty_talkie_counter = 0

@export var idle_time : float = randi_range(4, 12)


@onready var interaction_area: InteractionArea = $WKInteractionArea
@onready var timer = $Timer

func _ready():
	pick_new_state()
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals
	
	
	
	match kitty_state:
		KITTY_IDLE:
			new_anim = "sit_calmly"
		
		KITTY_LICK_FUR:
			new_anim = "groom_fur"
		
		KITTY_LICK_PAW:
			new_anim = "groom_paw"
		
		KITTY_LOOK:
			new_anim = "sit_turn_head"
		
		KITTY_MAD:
			new_anim = "sit_mad"
	
	if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
	pass

func DialogicSignalEvent(argument:String):
	if argument == "KittyTalkieCounter":
		kitty_talkie_counter += 1
		return
	if argument == "KittyMad":
		kitty_state = KITTY_MAD
		new_anim = "sit_mad"
		print("Dialogue Kitty Animation:")
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
	if argument == "KittyIdle":
		kitty_state = KITTY_IDLE
		new_anim = "sit_calmly"
		print("Dialogue Kitty Animation:")
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
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

func pick_new_state():
	var number = (randi() % 7)
	if number == 0:
		kitty_state = KITTY_LICK_FUR
		new_anim = "groom_fur"
		print(number)
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
	if number == 1:
		kitty_state = KITTY_LICK_PAW
		new_anim = "groom_paw"
		print(number)
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
	if number == 2: 
		kitty_state = KITTY_LOOK
		new_anim = "sit_turn_head"
		print(number)
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
	if number > 2:
		kitty_state = KITTY_IDLE
		new_anim = "sit_calmly"
		print(number)
		print(new_anim)
		if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
		return
	



#helper functions
func kitty_goto_idle():
	kitty_state = KITTY_IDLE
	new_anim = "sit_idle"

