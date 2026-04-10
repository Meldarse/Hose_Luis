extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var muzzle: Marker2D = $AnimatedSprite2D/Marker2D
@onready var shoot_sfx: AudioStreamPlayer = $ShootSFX
@onready var empty_sfx: AudioStreamPlayer = $EmptySFX


@export var drop_water_scene: PackedScene

var in_use: bool = false

#func _physics_process(_delta: float) -> void:
	#rotation_degrees = wrap(rotation_degrees, 0, 360)
	#if rotation_degrees > 0 and rotation_degrees < 135:
		#animated_sprite_2d.flip_h = true
	#else:
		#animated_sprite_2d.flip_h = false


func shoot():
	if GlobalScene.water_pressure > 0 and GlobalScene.fire_power > 0:
		shoot_sfx.play()
		GlobalScene.water_pressure -= 5
		var main_scene = get_tree().current_scene
		var water_container = main_scene.get_node("%WaterContainer")
		var drop_water = drop_water_scene.instantiate()
		var direction = muzzle.global_transform.x
		drop_water.launch(direction)
		drop_water.global_position = muzzle.global_position
		drop_water.set_color(Color.SKY_BLUE)
		water_container.call_deferred("add_child", drop_water)
	else:
		empty_sfx.play()
