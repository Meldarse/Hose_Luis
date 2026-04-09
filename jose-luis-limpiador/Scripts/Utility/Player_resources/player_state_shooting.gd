extends PlayerStateBase

var loop := false
var shooting := false

func start():
	if shooting:
		return
	loop = true
	shooting = true
	shoot_loop()


func on_physics_process(_delta: float) -> void:
	if Input.is_action_just_released("shoot"):
		loop = false
		state_machine.change_to(player.states.Idle)


func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") and not event.is_echo():
		if player.gun.rotation_degrees <= 45:
			player.gun.rotation_degrees = 315
		elif player.gun.rotation_degrees >= 134 and \
		player.gun.rotation_degrees < 314:
			player.gun.rotation_degrees = 225

	elif event.is_action_pressed("move_down") and not event.is_echo():
		if player.gun.rotation_degrees >= 314 or \
		player.gun.rotation_degrees == 0:
			player.gun.rotation_degrees = 45
		elif (player.gun.rotation_degrees >= 224 and \
		player.gun.rotation_degrees < 313) or \
		player.gun.rotation_degrees == 180:
			player.gun.rotation_degrees = 135
			
	elif event.is_action_pressed("move_right"):
		player.gun.rotation_degrees = 0
	elif event.is_action_pressed("move_left"):
		player.gun.rotation_degrees = 180


func shoot_loop():
	while loop:
		player.gun.shoot()
		await get_tree().create_timer(player.BULLET_INTERVALS).timeout
	
	shooting = false
