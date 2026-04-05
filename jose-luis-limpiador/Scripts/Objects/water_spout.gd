#@tool
extends RayCast2D

## Speed at which the laser extends when first fired, in pixels per seconds.
@export var cast_speed := 300.0
## Maximum length of the laser in pixels.
@export var max_length := 250.0
## Distance in pixels from the origin to start drawing and firing the laser.
@export var start_distance := 40.0
## Base duration of the tween animation in seconds.
@export var growth_time := 0.1
@export var color := Color.WHITE

@onready var water: Line2D = $water

var shooting: bool = false

func _physics_process(delta: float) -> void:
	if shooting:
		shoot(delta)
		var object = get_collider()
		if object != null and object.has_method("clean"):
			object.clean()
	else:
		target_position.x = 0.0
		water.points[1] = Vector2.ZERO

	force_raycast_update()



func shoot(delta) -> void:
	target_position.x = move_toward(
		target_position.x,
		max_length,
		cast_speed * delta
	)
	var laser_end_position := target_position
	force_raycast_update()

	if is_colliding():
		laser_end_position = to_local(get_collision_point())

	water.points[1] = laser_end_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shooting = true
	elif event.is_action_released("shoot"):
		shooting = false
