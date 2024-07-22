extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	$AnimationPlayer.play("bounce")
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(DialogicSignalEvent) #connects to dialogic signals
	$InteractionArea/CollisionShape2D.set_deferred("disabled", true)

func _on_interact():
	# Hide/disable the sprite
	var update_item = get_node("/root/InteractionManager")
	update_item.has_item = true
	$ItemSprite.hide()
	$SparkleSprite.hide()
	$InteractionArea/CollisionShape2D.set_deferred("disabled", true)
	
func DialogicSignalEvent(argument:String):
	if argument == "DaffodilReady":
		$InteractionArea/CollisionShape2D.set_deferred("disabled", false)
	pass
