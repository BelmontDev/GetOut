extends AnimatableBody2D
# Este nodo extiende de AnimatableBody2D, que es similar a StaticBody2D pero permite ser animado con AnimationPlayer o AnimationTree.
# Se usa cuando un cuerpo colisionable necesita moverse de forma animada, pero no con físicas automáticas.

func _process(delta):
	# Esta función se llama cada frame (no cada frame de física, sino cada frame visual).
	# `delta` es el tiempo que ha pasado desde el último frame, útil para hacer animaciones suaves si fuera necesario.

	global_position = get_parent().global_position
	# Hace que este nodo copie exactamente la posición global (en pantalla) de su nodo padre.
	# Esto lo “ancla” al mismo lugar que su padre, siguiéndolo perfectamente.

	pass
	# Instrucción vacía, no hace nada. Aquí se puede eliminar ya que no hay más líneas dentro del bloque.
