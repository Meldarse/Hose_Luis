extends PlayerStateBase

func start():
	player.jump_sfx.play()
	player.animation_player.play("jump")

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


func on_input(event):
	if event.is_action_pressed("shoot"):
		state_machine.change_to(player.states.Shooting)
