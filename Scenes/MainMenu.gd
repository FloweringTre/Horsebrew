extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	pass # Replace with function body.


func _on_play_pressed():
	$AnimationPlayer.play("GameStart")
	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://Scenes/the_forest.tscn")
	pass # Replace with function body.
