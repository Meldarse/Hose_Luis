extends Node

@export var intial_power: int
@export var height_penalty: int
var water_pressure: int = 200
var altitude: int =  0
var fire_power: int = 0
var clean_back: int = 0
var clean_front: int = 0
var grime: int = 0

func _process(_delta: float) -> void:
	fire_power = water_pressure + intial_power - ( altitude * height_penalty)
