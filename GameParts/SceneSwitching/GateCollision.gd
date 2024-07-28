extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
		Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals


func DialogicSignalEvent(argument:String):
	if argument == "GameEnd-Loose":
		disabled = true
	if argument == "GameEnd-Win":
		disabled = true
	pass

