class_name Drop
extends RigidBody2D


const DIAMETER: float = 12.0
const MESH_SIZE_OFFSET: float = 6.0


func set_color(color: Color) -> void:
	modulate = color
#
#@onready var left: RayCast2D = $left
#@onready var right: RayCast2D = $right
#

#func _physics_process(delta: float) -> void:
	#if linear_velocity == Vector2.ZERO:
		#linear_velocity = Vector2(10.0, 0.0)
		#constant_force += Vector2(100.0 * delta, 0.0) 
	#if left.is_colliding():
		#if linear_velocity == Vector2.ZERO:
			#linear_velocity = Vector2(10.0, 0.0)
		#constant_force += Vector2(100.0 * delta, 0.0) 
#
	#if right.is_colliding():
		#if linear_velocity == Vector2.ZERO:
			#linear_velocity = Vector2(-10.0, 0.0)
		#constant_force -= Vector2(100.0 * delta, 0.0) 
