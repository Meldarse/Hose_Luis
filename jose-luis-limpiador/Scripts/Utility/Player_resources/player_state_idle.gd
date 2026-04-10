extends PlayerStateBase


func start():
	player.animation_player.play("RESET")
	player.body.play("idle")

func on_physics_process(delta):
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * delta * 5.0)

	controlled_node.move_and_slide()

	if not controlled_node.is_on_floor():
		state_machine.change_to(player.states.Falling)

	if player.get_movement_direction():
		state_machine.change_to(player.states.Running)


func on_input(event):
	if event.is_action_pressed("jump"):  
		state_machine.change_to(player.states.Jumping)

	if event.is_action_pressed("shoot"):
		state_machine.change_to(player.states.Shooting)
