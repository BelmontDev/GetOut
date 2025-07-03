extends Area2D  
# Este nodo es un Area2D, útil para detectar colisiones con otros cuerpos como el jugador.

func _physics_process(delta):
	# Esta función se ejecuta en cada frame de física.
	# Aquí se revisa constantemente si hay colisiones con el jugador.

	if not is_inside_tree():
		# Verifica que el nodo esté correctamente insertado en el árbol de la escena.
		# Esto evita errores si el nodo es eliminado o no está listo aún.
		return  # Sale de la función si el nodo no está en la escena activa.

	for body in get_overlapping_bodies():
		# Itera sobre todos los cuerpos que están superpuestos con esta área.

		if body.name == "Player":
			# Si uno de los cuerpos tiene el nombre "Player", entonces se toma como colisión válida.
			# Alternativa más robusta: `body.is_in_group("jugador")` si usas grupos.

			get_tree().reload_current_scene()
			# Recarga completamente la escena actual.
			# Útil para reiniciar el nivel si el jugador cae en una trampa, toca lava, etc.
