extends Node3D



func _on_body_entered(body: Node) -> void:
	$Stone.play()
