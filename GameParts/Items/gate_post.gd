extends StaticBody2D


func _ready():
	$AnimationPlayer.play("RESET")
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals

func DialogicSignalEvent(argument:String):
	if argument == "PotionComplete":
		$AnimationPlayer.play("Ready")
	pass
