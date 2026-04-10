extends PlayerStateBase

var loop := false
var shooting := false

func start():
	player.body.play("idle")
	if shooting:
		return
	loop = true
	shooting = true
	shoot_loop()


func on_physics_process(delta: float) -> void:
	if not controlled_node.is_on_floor():
		var direction = player.get_movement_direction()
		var accel = player.ACCELERATION
		accel *= 0.5

		controlled_node.velocity.x = move_toward(controlled_node.velocity.x,
		direction * player.SPEED,
		accel * delta)

	if controlled_node.is_on_floor():
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * delta * 5.0)

	if Input.is_action_just_released("shoot"):
		loop = false
		state_machine.change_to(player.states.Idle)

	if Input.is_action_pressed("move_up"):
		if player.gun.rotation_degrees < 134:
			player.gun.rotation_degrees += 5
		elif player.gun.rotation_degrees > 136:
			player.gun.rotation_degrees -= 5

	if Input.is_action_pressed("move_down"):
		if player.body.flip_h and \
		player.gun.rotation_degrees >= 130 and \
		player.gun.rotation_degrees <= 140:
			player.gun.rotation_degrees -= 5
		elif not player.body.flip_h and \
		player.gun.rotation_degrees >= 130 and \
		player.gun.rotation_degrees <= 140:
			player.gun.rotation_degrees += 5
		if player.gun.rotation_degrees < 130 and player.gun.rotation_degrees > 0:
			player.gun.rotation_degrees -= 5
		elif player.gun.rotation_degrees > 140 and player.gun.rotation_degrees < 270:
			player.gun.rotation_degrees += 5

			
	if Input.is_action_pressed("move_left"):
		if player.gun.rotation_degrees > 45 and player.gun.rotation_degrees < 270:
			player.gun.rotation_degrees -= 5

	if Input.is_action_pressed("move_right"):
		if player.gun.rotation_degrees > 0 and player.gun.rotation_degrees < 225:
			player.gun.rotation_degrees += 5

	if  not controlled_node.is_on_floor():
		player.velocity += player.get_gravity() * delta

	controlled_node.move_and_slide()


func shoot_loop():
	while loop:
		player.gun.shoot()
		await get_tree().create_timer(player.BULLET_INTERVALS).timeout
	
	shooting = false
