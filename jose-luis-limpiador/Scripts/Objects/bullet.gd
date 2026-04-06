extends Area2D
 
const SPEED: int = 300
 
 
func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	queue_free()
	print("bala: adios")
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
 
