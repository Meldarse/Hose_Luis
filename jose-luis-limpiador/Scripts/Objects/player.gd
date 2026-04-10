class_name Player
extends CharacterBody2D

@export_category("Player Stats")
@export var SPEED = 120.0
@export var JUMP_VELOCITY = -300.0
@export var ACCELERATION = 1000.0
@export var BULLET_INTERVALS = 0.1
@export var GUN_ROTATION = 5

@export_category("Jump Feel")
@export var GRAVITY_UP: float = 10.0
@export var GRAVITY_DOWN: float = 18.0
@export var JUMP_CUT_MULTIPLIER: float = 0.35
@export var MAX_FALL_SPEED: float = 850.0

@export_category("Jump Helpers")
@export var COYOTE_TIME: float = 0.10
@export var JUMP_BUFFER_TIME: float = 0.10

@onready var body: AnimatedSprite2D = $Body
@onready var gun: Node2D = $Gun
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump_sfx: AudioStreamPlayer = $JumpSFX
@onready var step_sfx: AudioStreamPlayer = $StepSFX


var states: PlayerStateNames = PlayerStateNames.new()

var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0



func _physics_process(delta: float) -> void:
	_update_jump_timers(delta)
	_apply_variable_gravity(delta)
	_apply_jump_cut()


func _update_jump_timers(delta: float) -> void:
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer = max(coyote_timer - delta, 0.0)

	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME
	else:
		jump_buffer_timer = max(jump_buffer_timer - delta, 0.0)


func _apply_variable_gravity(delta: float) -> void:
	if is_on_floor():
		return

	if velocity.y < 0.0:
		velocity.y += GRAVITY_UP * delta
	else:
		velocity.y += GRAVITY_DOWN * delta

	velocity.y = min(velocity.y, MAX_FALL_SPEED)


func _apply_jump_cut() -> void:
	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= JUMP_CUT_MULTIPLIER



func get_movement_direction() -> float:
	return Input.get_axis("move_left", "move_right")


func can_jump() -> bool:
	return is_on_floor() or coyote_timer > 0.0


func has_jump_buffered() -> bool:
	return jump_buffer_timer > 0.0


func do_jump() -> void:
	velocity.y = JUMP_VELOCITY
	coyote_timer = 0.0
	jump_buffer_timer = 0.0
