extends Area2D

func _physics_process(delta):
	if not is_inside_tree():  # Asegura que esté en la escena
		return

	for body in get_overlapping_bodies():
		if body.name == "Player":  # O usa body.is_in_group("jugador")
			get_tree().reload_current_scene()
