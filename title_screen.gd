extends Node2D

var button_type = null

# Called when the play button is pressed.
func _on_play_pressed():
	button_type = "start"
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("fade_in")

# Called when the quit button is pressed.
func _on_quit_pressed():
	get_tree().quit()

# Called when the fade timer times out.
func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://info.tscn")
