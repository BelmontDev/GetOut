extends Control

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	

func _ready():
	$"VBoxContainer-Options/Size".add_item("1280x720")
	$"VBoxContainer-Options/Size".add_item("1920x1080")
	$"VBoxContainer-Options/Size".add_item("Fullscreen")


func _on_Resolution_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1280, 720))
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_size_item_selected(index: int) -> void:
	pass # Replace with function body.
