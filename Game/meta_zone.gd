extends Area2D  
# El nodo principal es un Area2D, usado para detectar colisiones con otros cuerpos (como el jugador) dentro de un área.

@onready var victory_menu_scene := preload("res://finished_menu.tscn")  
# Pre-carga la escena del menú de victoria (aunque en este script no se usa directamente).
# La variable se inicializa automáticamente cuando el nodo esté listo gracias a @onready.
# NOTA: Esta variable no se usa porque en `show_victory_menu()` se usa `change_scene_to_file`, no `instantiate()`.

func _on_body_entered(body: Node2D) -> void:
	# Esta función se ejecuta automáticamente cuando un cuerpo entra en el área de colisión de este nodo.
	# `body` es el nodo que ha entrado.

	if body.name == "Player":
		# Verifica que el nodo que entró se llama "Player".

		if body.points == 5:
			# Comprueba si el jugador tiene exactamente 5 puntos (puedes cambiar este valor según el requisito del juego).

			show_victory_menu()
			# Llama a la función que cambia a la escena de victoria.

func show_victory_menu():
	# Esta función cambia la escena actual por el menú principal de victoria.

	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	# Cambia completamente la escena activa del juego por "menu.tscn", que está ubicada en la carpeta Menu.
	# Es una transición directa, reemplazando la escena actual por la nueva.
