extends Control

@onready var water_pressure: Label = $WaterPressure
@onready var altitude: Label = $Altitude
@onready var fire_power: Label = $FirePower
@onready var grime: Label = $Grime


func _process(_delta: float) -> void:
	water_pressure.text = "Presion de agua: " + str(GlobalScene.water_pressure)
	altitude.text = "Nivel de altitud: " + str(GlobalScene.altitude)
	fire_power.text = "Potencia de disparo: " + str(GlobalScene.fire_power)
	grime.text = "Suciedad: " + str(GlobalScene.grime -
	(GlobalScene.clean_front + GlobalScene.clean_back))
