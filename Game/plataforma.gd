extends Area2D
# Este nodo representa una plataforma con diferentes comportamientos dependiendo de su tipo.

# === ENUM DE TIPOS DE PLATAFORMA ===
enum TipoPlataforma { FIJA, OSCILATORIA, FRAGIL, REBOTE, ARRIBA_ABAJO }
# Los tipos de plataforma que pueden existir: fija, oscilatoria, frágil, rebotante, arriba-abajo

# === VARIABLES EXPORTADAS ===
@export var tipo: TipoPlataforma = TipoPlataforma.FIJA
# Tipo de plataforma, por defecto es FIJA

@export var fuerza_rebote := 2.0
# Fuerza del rebote, afecta a plataformas de tipo REBOTE

# === FUNCIONES DE INICIALIZACIÓN ===
func _ready():
	actualizar_plataforma()
	# Actualiza el comportamiento y apariencia de la plataforma al iniciar

	monitorable = true
	monitoring = true
	# Hace que la plataforma pueda detectar colisiones con otros cuerpos (como el jugador)
	
# === FUNCIÓN PARA ACTUALIZAR EL COMPORTAMIENTO DE LA PLATAFORMA ===
func actualizar_plataforma():
	# Dependiendo del tipo de plataforma, se modifica su apariencia y comportamiento
	match tipo:
		TipoPlataforma.ARRIBA_ABAJO:
			$Sprite2D.modulate = Color.WEB_PURPLE
			# Establece el color a morado para plataformas arriba-abajo
			arribajo()  # Llama a la función de movimiento arriba-abajo
		TipoPlataforma.FIJA:
			$Sprite2D.modulate = Color.GREEN
			# Establece el color a verde para plataformas fijas
		TipoPlataforma.OSCILATORIA:
			$Sprite2D.modulate = Color.BLUE
			# Establece el color a azul para plataformas oscilatorias
			oscila()  # Llama a la función de movimiento oscilatorio
		TipoPlataforma.FRAGIL:
			$Sprite2D.modulate = Color.RED
			# Establece el color a rojo para plataformas frágiles
		TipoPlataforma.REBOTE:
			$Sprite2D.modulate = Color.YELLOW
			# Establece el color a amarillo para plataformas rebotantes
	 
# === FUNCIONES DE INTERACCIÓN CON EL JUGADOR ===
func _on_body_entered(body: Node2D) -> void:
	# Detecta si un cuerpo ha entrado en la plataforma
	if body.is_in_group("jugador"):
		# Si el cuerpo es el jugador
		match tipo: 
			TipoPlataforma.FIJA:
				$Sprite2D.modulate = Color.GREEN
				# Si es una plataforma fija, mantiene su color verde
			TipoPlataforma.FRAGIL:
				# Si es una plataforma frágil, espera 0.5 segundos antes de eliminarla
				await get_tree().create_timer(0.5).timeout
				queue_free()  # Elimina la plataforma
				$Sprite2D.modulate = Color.RED
			TipoPlataforma.REBOTE:
				# Si es una plataforma rebotante, rebota al jugador
				if body.has_method("puede_rebotar"):
					body.puede_rebotar(fuerza_rebote)  # Llama a la función personalizada "puede_rebotar" del jugador
				else:
					# Si el jugador no tiene esa función, se aplica la fuerza de rebote directamente a la velocidad Y
					body.velocity.y = body.brinco * fuerza_rebote
	pass  # Esta línea puede ser reemplazada por la implementación de otras funcionalidades

# === MOVIMIENTO DE LA PLATAFORMA (OSILACIÓN) ===
func oscila():
	var tween = create_tween()
	# Crea un tween para animar el movimiento
	tween.tween_property(self, "position:x", position.x + 100, 2)
	# Mueve la plataforma 100 unidades hacia la derecha durante 2 segundos
	tween.tween_property(self, "position:x", position.x - 100, 2)
	# Mueve la plataforma 100 unidades hacia la izquierda durante 2 segundos
	tween.set_loops()
	# Establece que el movimiento se repita en bucle

# === MOVIMIENTO DE LA PLATAFORMA (ARRIBA Y ABAJO) ===
func arribajo():
	var tween = create_tween()
	# Crea un tween para animar el movimiento
	tween.tween_property(self, "position:y", position.y + 100, 1)
	# Mueve la plataforma 100 unidades hacia abajo durante 1 segundo
	tween.tween_property(self, "position:y", position.y - 100, 1)
	# Mueve la plataforma 100 unidades hacia arriba durante 1 segundo
	tween.set_loops()
	# Establece que el movimiento se repita en bucle
