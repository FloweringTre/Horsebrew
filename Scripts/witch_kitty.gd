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
	if kitty_talkie_counter == 0:
		Dialogic.start("res://Dialogue/KittyExplain1.dtl")
		await Dialogic.timeline_ended
	else:
		print("I have been interacted with... but I have no dialogue to give")
		pass

