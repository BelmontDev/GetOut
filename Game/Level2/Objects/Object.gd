extends Area2D
# Este nodo es un Area2D, útil para detectar cuando el jugador entra en contacto con él.
# Se usa para representar un objeto recolectable, como una moneda o gema.

func _on_body_entered(body):
	# Esta función se ejecuta automáticamente cuando un cuerpo entra en el área de colisión del nodo (usando la señal `body_entered`).
	# `body` es el objeto que ha tocado este nodo.

	if body.name == "Player":
		# Verifica que el cuerpo que ha entrado se llama "Player".
		# Alternativamente, podrías usar `body.is_in_group("Player")` para mayor flexibilidad.

		body.Pickup_Gem()
		# Llama a la función `Pickup_Gem()` definida en el script del jugador para aumentar su contador de gemas o puntos.

		queue_free()
		# Elimina (libera) este nodo de la escena, haciendo que la moneda desaparezca una vez recogida.
