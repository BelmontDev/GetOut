extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.Pickup_Gem()
		queue_free()  # Desaparece la moneda
