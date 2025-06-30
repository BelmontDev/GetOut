extends Node2D

@onready var victory_menu_scene := preload("res://finished_menu.tscn") # Asegúrate que esta ruta esté bien

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.points == 5: # Cambia a la cantidad que necesitas
			show_victory_menu()

func show_victory_menu():
	var victory_menu = victory_menu_scene.instantiate()
	get_tree().get_root().add_child(victory_menu)  # Muestra el menú en pantalla
	get_tree().paused = true  # Pausa el juego si quieres
