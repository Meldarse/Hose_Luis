extends PlayerStateBase


func start():
	player.gun.shoot()

func on_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		state_machine.change_to(player.states.Idle)
