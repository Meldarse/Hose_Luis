extends Area2D

@export var altitude_level: int

func _on_body_entered(_body: Node2D) -> void:
	GlobalScene.altitude = altitude_level
