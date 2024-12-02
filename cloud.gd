extends RigidBody3D

var Player

func _ready():
	Player = get_tree().get_nodes_in_group("Player")[0]




func _on_hurt_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("Cloud entered by Player")
		get_tree().call_group("Player","hurt", 1)
