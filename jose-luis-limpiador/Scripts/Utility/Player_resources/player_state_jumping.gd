extends PlayerStateBase

func on_physics_process(delta):
	player.body.play("jump")
	var direction = player.get_movement_direction()
	var accel = player.ACCELERATION

	if not controlled_node.is_on_floor():
		accel *= 0.5
	
	controlled_node.velocity.x = move_toward(controlled_node.velocity.x,
		direction * player.SPEED,
		accel * delta)

	if controlled_node.is_on_floor() and controlled_node.velocity.y >= 0: 
		controlled_node.velocity.y = player.JUMP_VELOCITY

	elif controlled_node.velocity.y > 0:
		state_machine.change_to(player.states.Falling)
	
	player.velocity += player.get_gravity() * delta

	controlled_node.move_and_slide()
