extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()



func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
