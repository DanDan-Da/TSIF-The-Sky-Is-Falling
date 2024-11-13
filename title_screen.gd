extends Node2D


# Called when the node enters the scene tree for the first time.
func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	print("ENTERING GAME")
	get_tree().change_scene_to_file("res://level_1.tscn")

	pass # Replace with function body.
