extends Node2D

func _ready():
	$AnimationPlayer.play("bubbling_finished")
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals

func DialogicSignalEvent(argument:String):
	if argument == "InitalDialogueEnd":
		$AnimationPlayer.play("RESET")
	if argument == "DaffodilReady":
		$AnimationPlayer.play("sizzling_lotus")
	if argument == "ShellReady":
		$AnimationPlayer.play("sizzling_daffodil")
	if argument == "BerryReady":
		$AnimationPlayer.play("bubbling_shell")
	if argument == "StarReady":
		$AnimationPlayer.play("bubbling_berry")
	if argument == "PotionComplete":
		$AnimationPlayer.play("bubbling_finished")
	pass

