extends PlayerStateBase


func on_physics_process(delta):
	player.velocity += player.get_gravity() * delta

	var direction = player.get_movement_direction()
	var accel = player.ACCELERATION
	if not controlled_node.is_on_floor():
		accel *= 0.5

	controlled_node.velocity.x = move_toward(controlled_node.velocity.x,
		direction * player.SPEED,
		accel * delta)

	if player.velocity.y >= 0 and player.is_on_floor(): 
		state_machine.change_to(player.states.Idle)
	

	controlled_node.move_and_slide()
