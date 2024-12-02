extends Node

var Player

func _ready():
	Player = get_tree().get_nodes_in_group("Player")[0]

func _on_hurt_box_body_entered(body):
	if body.is_in_group("Player"):
		print("Snowball entered by Player")
		get_tree().call_group("Player","hurt", 1)
