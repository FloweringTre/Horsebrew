extends Node2D

var anim = ""
var new_anim = ""

enum { KITTY_IDLE, KITTY_LICK, KITTY_LAYDOWN, KITTY_SLEEP, KITTY_ITCH, KITTY_TALK }

var kitty_state = KITTY_IDLE


func _ready():
	match kitty_state:
		KITTY_IDLE:
			new_anim = "idle"
		
	
	if new_anim != anim:
			anim = new_anim
			$AnimationPlayer.play(anim)
	pass
