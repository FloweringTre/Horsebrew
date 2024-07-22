extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.signal_event.connect(DialogicSignalEvent)
	modulate.a = 0.4


func DialogicSignalEvent(argument:String):
	if argument == "LevelUp":
		level_up()
	pass

func level_up():
	modulate.a += 0.12
	if modulate.a > 1:
		modulate.a = 1
