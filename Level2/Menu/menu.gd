extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Player/world.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/Options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit() #Salir del Fkin Juego
