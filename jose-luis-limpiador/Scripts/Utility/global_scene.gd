extends Node

var water_pressure: int = 200
var altitude: int =  0
var fire_power: int = 0

func _process(_delta: float) -> void:
	fire_power = water_pressure - ( altitude * 200)
