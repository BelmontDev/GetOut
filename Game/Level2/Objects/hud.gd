extends CanvasLayer  
# El nodo extiende de CanvasLayer, lo que permite mostrar elementos de UI (como texto) que siempre se dibujan sobre el resto de la escena.

func update_count(Gem: int):
	# Esta función actualiza el texto que muestra la cantidad de gemas (o puntos).
	# El parámetro 'Gem' representa la nueva cantidad de gemas a mostrar.

	$GemValue.text = str(Gem)
	# Accede al nodo hijo llamado "GemValue" (probablemente una Label) y actualiza su texto con el valor recibido.
	# str(Gem) convierte el número entero a texto para que pueda ser mostrado.
