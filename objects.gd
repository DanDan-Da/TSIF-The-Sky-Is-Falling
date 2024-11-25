extends Node3D

@export var spawn_interval: float = 3.0  # Time between spawns
@export var spawn_range_x: Vector2 = Vector2(-5, 5)  # X range for spawning
@export var spawn_range_z: Vector2 = Vector2(-5, 5)  # Z range for spawning
@export var spawn_height: float = 20.0  # Y position for spawning
@export var initial_fall_impulse: float = 10.0  # Initial downward force

var spawn_timer: Timer  # Timer for spawning new objects

func _ready():
	randomize()  # Ensure randomness
	setup_spawn_timer()

# Set up the spawn timer to create objects at regular intervals
func setup_spawn_timer():
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", Callable(self, "spawn_object"))
	add_child(spawn_timer)
	spawn_timer.start()

# Function to spawn a random object at a random position
func spawn_object():
	var children = get_children()
	if children.size() > 0:
		# Pick a random object to spawn
		var random_child = children[randi() % children.size()]
		var new_object = random_child.duplicate()
		add_child(new_object)

		# Set a random spawn position
		new_object.global_transform.origin = Vector3(
			randf_range(spawn_range_x.x, spawn_range_x.y),  # Random X
			spawn_height,                                  # Spawn height
			randf_range(spawn_range_z.x, spawn_range_z.y)  # Random Z
		)

		# Ensure the object has a collision shape
		if new_object is RigidBody3D:
			var collision = new_object.get_node("CollisionShape3D")
			if collision:
				collision.disabled = false  # Ensure the collision is active

			# Reset physics velocity before applying the impulse
			new_object.linear_velocity = Vector3.ZERO
			new_object.angular_velocity = Vector3.ZERO

			# Apply the initial downward impulse to make the object fall
			new_object.apply_impulse(Vector3.ZERO, Vector3(0, -initial_fall_impulse, 0))
