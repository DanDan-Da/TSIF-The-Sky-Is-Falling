extends Node2D
@onready var Fade_trasition =$Fade_transition
func _ready():
	$Fade_transition.hide()  # Hide the fade transition at the start

# Called when the video finishes
func _on_VideoStreamPlayer_finished():
	$Fade_transition.show()  # Show the fade effect
	$Fade_transition/AnimationPlayer.play("fade_in")

# Handle fade-out completion
func _on_fade_timer_timeout():
	pass

func _on_video_stream_player_finished() -> void:
	print(1)
	get_tree().change_scene_to_file("res://level_1.tscn")
