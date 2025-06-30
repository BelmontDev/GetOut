extends Area2D

@onready var victory_menu_scene := preload("res://finished_menu.tscn") # Asegúrate que esta ruta esté bien

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.points == 5: # Cambia este número si quieres otra cantidad
			show_victory_menu()

func show_victory_menu():
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
