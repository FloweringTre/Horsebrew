extends Node2D

@onready var gamesuccess = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	var update_item = get_node("/root/InteractionManager")
	if gamesuccess == false:
		Dialogic.start("res://Dialogue/GateNOTReadytimeline.dtl")
		await Dialogic.timeline_ended
		return
	if gamesuccess == true:
		Dialogic.start("res://Dialogue/GateReadytimeline.dtl")
		await Dialogic.timeline_ended
		return
	else:
		print("I have been interacted with... but I have no dialogue to give")
		pass
