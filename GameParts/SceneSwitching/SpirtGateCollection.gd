extends StaticBody2D

@export var to_scene = "" # (String, FILE, "*.tscn")
@export var spawnpoint: String = ""

func _ready():
	$TravelGate.to_scene = to_scene
	$TravelGate.spawnpoint = spawnpoint
	pass # Replace with function body.
	
	
