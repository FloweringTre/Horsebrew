extends CollisionShape2D

@onready var gamelevel = Globals.horse_level
# Called when the node enters the scene tree for the first time.
func _ready():
	if gamelevel < 5:
		disabled = true
	pass # Replace with function body.


