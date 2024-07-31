extends Node

# warning-ignore:unused_class_variable
var spawnpoint = ""
var current_level = ""
var horse_level = 0

func _ready():
	RenderingServer.set_default_clear_color(Color.WHITE)
	Dialogic.signal_event.connect(DialogicSignalEvent)
	
func DialogicSignalEvent(argument:String):
	if argument == "LevelUp":
		level_up()
	pass

func level_up():
	horse_level += 1
