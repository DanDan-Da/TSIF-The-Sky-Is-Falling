extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const PUSH_FORCE = 1.0  # Adjust to control the strength of the push
const MIN_PUSH_FORCE = 0.5  # Minimum force applied when pushing
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")  # Retrieve default gravity setting

func _physics_process(delta: float) -> void:
	# Add gravity if the player is not on the floor
	if not is_on_floor():
		velocity.y -= gravity * delta  # Update only the Y component of the velocity

	# Handle jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get input direction for movement
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	


	# Update velocity based on input direction
	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		# Make the character face the direction of movement (only around Y-axis)
		var target_rotation = atan2(direction.x, direction.z)  # Use correct axis for Godot's forward direction
		rotation.y = lerp_angle(rotation.y, target_rotation, 0.1)  # Smoothly rotate to the target direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta)

	# Move the character and apply the calculated velocity
	move_and_slide()

	# Handle pushing objects
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody3D:
			var push_force = (PUSH_FORCE * velocity.length() / SPEED) + MIN_PUSH_FORCE
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)
