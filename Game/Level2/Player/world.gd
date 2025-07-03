extends Node2D  # Esta línea indica que el script extiende la clase Node2D, lo que significa que este nodo se comporta como un nodo 2D en la escena.

@onready var victory_menu_scene := preload("res://finished_menu.tscn")  
# Declara una variable llamada 'victory_menu_scene' y precarga (load en tiempo de compilación) la escena 'finished_menu.tscn' desde el path indicado.
# La anotación '@onready' significa que esta variable se inicializará una vez que el nodo esté listo (es decir, en _ready o después).

func _on_body_entered(body: Node2D) -> void:
	# Esta función es una señal que se llama automáticamente cuando un cuerpo entra en el área de colisión asociada a este nodo.
	# El parámetro 'body' representa el nodo que ha entrado en el área.

	if body.name == "Player":
		# Verifica si el nodo que ha entrado se llama "Player".

		if body.points == 5:
			# Verifica si el jugador (body) tiene exactamente 5 puntos.
			# Cambia el número 5 a la cantidad de puntos que quieres requerir para mostrar el menú de victoria.

			show_victory_menu()
			# Llama a la función que muestra el menú de victoria.

func show_victory_menu():
	# Esta función instancia y muestra el menú de victoria en pantalla.

	var victory_menu = victory_menu_scene.instantiate()
	# Crea una instancia (copia activa) del menú de victoria precargado anteriormente.

	get_tree().get_root().add_child(victory_menu)
	# Agrega la instancia del menú al nodo raíz de la escena actual, haciendo que se muestre en pantalla.

	get_tree().paused = true
	# Pausa la ejecución del árbol de nodos del juego, deteniendo todas las físicas, animaciones y scripts.
	# Esto sirve para congelar el juego mientras se muestra el menú de victoria.
