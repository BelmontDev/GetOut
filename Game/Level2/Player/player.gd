extends CharacterBody2D  
# Este script extiende de CharacterBody2D, lo que significa que controla un personaje con física integrada (como colisiones y movimiento).

var speed := 150  
# Velocidad horizontal del personaje (pixeles por segundo).

var direccion := 0.0  
# Dirección del movimiento horizontal: -1 (izquierda), 0 (quieto), 1 (derecha).

var jump := 300  
# Fuerza del salto hacia arriba.

var points = 0  
# Contador de puntos (por ejemplo, recogiendo gemas).

const gravity := 10  
# Constante de gravedad que se aplica cuando el personaje está en el aire.

@onready var anim := $AnimatedSprite2D  
# Obtiene automáticamente la referencia al nodo hijo "AnimatedSprite2D" cuando el nodo esté listo.

var was_on_floor := false  
# Booleano que guarda si el personaje estaba en el suelo en el frame anterior.

var landing_timer := 0.0  
# Temporizador que controla cuánto dura la animación de aterrizaje.

var landing_duration := .2  
# Duración (en segundos) de la animación de aterrizaje (0.2 segundos).

func _physics_process(delta: float) -> void:
	# Esta función se llama en cada frame de física. Aquí se maneja el movimiento y las animaciones.

	direccion = Input.get_axis("ui_left", "ui_right")
	# Obtiene el valor de entrada horizontal: -1 para izquierda, 1 para derecha, 0 si no se presiona nada.

	velocity.x = direccion * speed
	# Calcula la velocidad horizontal multiplicando dirección por velocidad.

	# Si el personaje está en animación de aterrizaje, actualiza el temporizador.
	if landing_timer > 0:
		landing_timer -= delta  # Resta el tiempo transcurrido al temporizador.
		if landing_timer <= 0:
			anim.play("Idle" if direccion == 0 else "Walk")
			# Cuando termina la animación de aterrizaje, reproduce "Idle" o "Walk" dependiendo si se está moviendo.

			landing_timer = 0  # Reinicia el temporizador.

	# Control de animaciones según el estado del personaje.
	if not is_on_floor():
		anim.play("Jump")  # Si está en el aire, reproduce animación de salto.
	elif direccion != 0 and landing_timer <= 0:
		anim.play("Walk")  # Si se está moviendo en el suelo, reproduce caminata.
	elif landing_timer <= 0:
		anim.play("Idle")  # Si está quieto en el suelo, reproduce idle.

	anim.flip_h = direccion < 0 if direccion != 0 else anim.flip_h
	# Voltea la animación horizontalmente si se mueve a la izquierda.

	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
		# Si el personaje está en el suelo y se presiona la tecla de salto, aplica la velocidad de salto hacia arriba.

		anim.play("Jump")  # Reproduce animación de salto.

	if not is_on_floor():
		velocity.y += gravity
		# Si no está en el suelo, aplica gravedad para que caiga.

	# Si acaba de aterrizar (estaba en el aire y ahora está en el suelo)
	if is_on_floor() and not was_on_floor and landing_timer <= 0:
		anim.play("Land")  # Reproduce animación de aterrizaje.
		landing_timer = landing_duration  # Activa el temporizador de aterrizaje.

	was_on_floor = is_on_floor()
	# Guarda si el personaje está en el suelo para usarlo en el siguiente frame.

	move_and_slide()
	# Aplica la velocidad al cuerpo y maneja colisiones automáticamente.


func Pickup_Gem():
	# Función llamada cuando el personaje recoge una gema.

	points += 1
	# Incrementa el contador de puntos.

	get_node("/root/World/HUD").update_count(points)
	# Llama a la función 'update_count' del HUD para mostrar el nuevo número de puntos en pantalla.
