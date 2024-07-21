extends Node2D

var anim = ""
var new_anim = ""

enum { KITTY_IDLE, KITTY_LICK, KITTY_LAYDOWN, KITTY_SLEEP, KITTY_ITCH, KITTY_TALK }

var kitty_state = KITTY_IDLE


@onready var interaction_area: InteractionArea = $WKInteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

	
	match kitty_state:
		KITTY_IDLE:
			new_anim = "idle"
		
	
	if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
	pass

func _on_interact():
	Dialogic.start("res://Dialogue/KittyExplain1.dtl")
	await Dialogic.timeline_ended
