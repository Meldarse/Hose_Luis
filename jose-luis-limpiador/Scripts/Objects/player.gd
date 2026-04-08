class_name Player extends CharacterBody2D

@export_category("Player Stats")
@export var SPEED = 250.0
@export var JUMP_VELOCITY = -400.0
@export var ACCELERATION = 1000.0

@onready var body: AnimatedSprite2D = $Body
@onready var right: RayCast2D = $Right
@onready var left: RayCast2D = $Left
@onready var gun: Node2D = $Gun


var states:PlayerStateNames = PlayerStateNames.new()

func _physics_process(_delta: float) -> void:
	if left.is_colliding():
		var collider = left.get_collider()

		if collider is RigidBody2D:
			var normal = left.get_collision_normal()
			collider.apply_impulse(-normal * 2.5)

	if right.is_colliding():
		var collider = right.get_collider()

		if collider is RigidBody2D:
			var normal = right.get_collision_normal()
			collider.apply_impulse(-normal * 2.5)


func get_movement_direction() -> float:
	return Input.get_axis("move_left", "move_right")
