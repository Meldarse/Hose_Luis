class_name Drop
extends RigidBody2D

@onready var left: RayCast2D = $left
@onready var right: RayCast2D = $right

const DIAMETER: float = 12.0
const MESH_SIZE_OFFSET: float = 6.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var impact: bool = false


func set_color(color: Color) -> void:
	modulate = color

func _physics_process(delta: float) -> void:
	if linear_velocity.y > 1.0:
		animation_player.play("on_air")

	else:
		animation_player.play("RESET")
	if left.is_colliding():
		if linear_velocity == Vector2.ZERO:
			linear_velocity = Vector2(10.0, 0.0)
		constant_force += Vector2(100.0 * delta, 0.0) 

	if right.is_colliding():
		if linear_velocity == Vector2.ZERO:
			linear_velocity = Vector2(-10.0, 0.0)
		constant_force -= Vector2(100.0 * delta, 0.0) 


func launch(direction: Vector2):
	linear_velocity = direction * GlobalScene.fire_power


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self and body.has_method("clean"):
		body.clean(global_position)
