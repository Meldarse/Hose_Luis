extends RigidBody2D

@export var drop_water_scene: PackedScene
var impact: bool = false

func _ready():
	await get_tree().create_timer(2.0).timeout
	queue_free()

func launch(direction: Vector2):
	linear_velocity = direction * GlobalScene.fire_power


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self and impact == false:
		impact = true
		var main_scene = get_tree().current_scene
		var water_container = main_scene.get_node("%WaterContainer")
		var drop_water = drop_water_scene.instantiate()
		drop_water.global_position = global_position
		drop_water.set_color(Color.SKY_BLUE)
		water_container.call_deferred("add_child", drop_water)
		call_deferred("queue_free")
