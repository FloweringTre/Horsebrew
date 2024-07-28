extends Node2D

@onready var GameStart = false

func _ready():
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals
	Dialogic.start("res://Dialogue/InitialDialogue.dtl")
	pass
	
func DialogicSignalEvent(argument:String):
	if argument == "InitalDialogueEnd":
		GameStart = true
	pass

