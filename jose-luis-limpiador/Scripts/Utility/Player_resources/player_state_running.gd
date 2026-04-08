extends PlayerStateBase


func start():
	player.body.play("run")

func on_physics_process(delta):
	var direction = player.get_movement_direction()
	controlled_node.velocity.x = move_toward(
		controlled_node.velocity.x,
		direction * player.SPEED,
		player.ACCELERATION * delta)


	controlled_node.move_and_slide()

	if player.velocity.x < 0:
		player.body.flip_h = true
	else:
		player.body.flip_h = false

	if direction == 0.0:
		state_machine.change_to(player.states.Idle)

	if not controlled_node.is_on_floor():
		state_machine.change_to(player.states.Falling)

func on_input(_event):
	if Input.is_action_just_pressed("jump"): 
		state_machine.change_to(player.states.Jumping)
