extends Node2D


@onready var muzzle: Marker2D = $Marker2D
@onready var bullets: Node2D = $Bullets

@export var cannon_ball_scene: PackedScene

var in_use: bool = false

func _physics_process(_delta: float) -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1


func shoot():
	if GlobalScene.water_pressure > 0 and GlobalScene.fire_power > 0:
		GlobalScene.water_pressure -= 5
		var ball = cannon_ball_scene.instantiate()
		ball.global_position = muzzle.global_position
		var direction = muzzle.global_transform.x
		ball.launch(direction)
		bullets.add_child(ball)
