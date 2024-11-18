extends Area3D

var ROT_SPEED = 2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))



func _on_body_entered(body: Node3D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position - Vector3(0,-2.5,0), 0.3)
	tween.tween_callback(queue_free)
	
