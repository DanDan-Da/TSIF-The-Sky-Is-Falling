extends Node3D

@export var spawn_interval: float = 0.  # Time between spawns
@export var spawn_range_x: Vector2 = Vector2(-4.5, 4.5)  # X range for spawning
@export var spawn_range_z: Vector2 = Vector2(-4.5, 4.5)  # Z range for spawning
@export var spawn_height: float = 20.0  # Y position for spawning
@export var initial_fall_impulse: float = 10.0  # Initial downward force

var spawn_timer: Timer  # Timer for spawning new objects
var spawnable_objects: Array = []  # Array to hold the original spawnable objects

func _ready():
	randomize()  # Ensure randomness
	initialize_spawnable_objects()
	setup_spawn_timer()

# Initialize the spawnable objects array with the original children
func initialize_spawnable_objects():
	for child in get_children():
		spawnable_objects.append(child)

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
	if spawnable_objects.size() > 0:
		# Pick a random object to spawn from the original pool
		var random_child = spawnable_objects[randi() % spawnable_objects.size()]
		var new_object = random_child.duplicate() as Node3D  # Ensure it's a Node3D

		if new_object:
			add_child(new_object)

			# Set a random spawn position
			var spawn_position = Vector3(
				randf_range(spawn_range_x.x, spawn_range_x.y),  # Random X
				spawn_height,                                  # Spawn height
				randf_range(spawn_range_z.x, spawn_range_z.y)  # Random Z
			)
			new_object.global_transform.origin = spawn_position

			# If the new object is a RigidBody3D, apply physics
			if new_object is RigidBody3D:
				new_object.linear_velocity = Vector3.ZERO
				new_object.angular_velocity = Vector3.ZERO

				# Apply the initial downward impulse
				new_object.apply_impulse(Vector3.ZERO, Vector3(0, -initial_fall_impulse, 0))
