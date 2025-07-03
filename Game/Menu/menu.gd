extends Control  
# El script extiende de la clase Control, usada para crear interfaces gráficas (botones, menús, etc.).

func _on_play_pressed() -> void:
	# Esta función se ejecuta cuando el botón "Play" es presionado.
	
	get_tree().change_scene_to_file("res://nivel0.tscn")
	# Cambia la escena actual y carga "nivel0.tscn", que se asume es el primer nivel del juego.

func _on_settings_pressed() -> void:
	# Esta función se ejecuta cuando el botón "Settings" (Opciones) es presionado.

	get_tree().change_scene_to_file("res://Menu/Options.tscn")
	# Cambia la escena actual y carga la escena de opciones ubicada en "Menu/Options.tscn".

func _on_exit_pressed() -> void:
	# Esta función se ejecuta cuando el botón "Exit" es presionado.

	get_tree().quit()
	# Cierra completamente el juego.
	# Comentario gracioso: "#Salir del Fkin Juego"
