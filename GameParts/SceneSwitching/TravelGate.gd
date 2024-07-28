extends Area2D

class_name TravelGate

"""
Add this to any area2d and it will send the player to the indicated scene and spawnpoint
"""

@export var to_scene = "" # (String, FILE, "*.tscn")
@export var spawnpoint: String = ""
@export var gamesuccess = false
@onready var GameStart = false
@onready var movescene = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered, CONNECT_DEFERRED)
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals
	
func DialogicSignalEvent(argument:String):
	if argument == "InitalDialogueEnd":
		GameStart = true
	if argument == "PotionComplete":
		gamesuccess = true
	if argument == "GameEnd-Loose":
		movescene = true
	if argument == "GameEnd-Win":
		movescene = true
	pass


func _on_body_entered(body):
	if GameStart == false:
		return
	if gamesuccess == false:
		Dialogic.start("res://Dialogue/GateNotReady.dtl")
		await Dialogic.timeline_ended
		if movescene == true:
			get_tree().change_scene_to_file("res://Scenes/mortal_realm.tscn")
		else:
			return
		return
	if gamesuccess == true:
		Dialogic.start("res://Dialogue/GateReady.dtl")
		await Dialogic.timeline_ended
		if movescene == true:
			get_tree().change_scene_to_file("res://Scenes/mortal_realm.tscn")
		else:
			return
		return


func _on_body_exited(body):
	if movescene == true:
		get_tree().change_scene_to_file("res://Scenes/mortal_realm.tscn")
	else:
		pass
