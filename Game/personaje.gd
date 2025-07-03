extends CharacterBody2D
# Este nodo representa al jugador principal, controlado por el usuario con movimiento, salto, animaciones y reacciones a eventos.

# === VARIABLES DE MOVIMIENTO ===
var velocidad = 200        # Velocidad horizontal
var brinco = -400          # Impulso de salto (negativo = hacia arriba)
var gravedad = 1000        # Aceleración hacia abajo (pixeles/seg²)

# === REFERENCIA AL SPRITE ANIMADO ===
@onready var animated_sprite = $AnimatedSprite
# Se accede al nodo de animación del personaje (debe llamarse "AnimatedSprite")

# === INICIO DEL NODO ===
func _ready():
	add_to_group("jugador")  # Añade este nodo al grupo "jugador" para facilitar detección desde otras escenas


# === MOVIMIENTO Y FÍSICAS ===
func _physics_process(delta):
	var direccion = Input.get_axis("ui_left", "ui_right")
	# Detecta si se está presionando izquierda (-1), derecha (1) o nada (0)

	velocity.x = direccion * velocidad
	# Calcula la velocidad horizontal basada en la dirección y velocidad base

	if not is_on_floor():
		velocity.y += gravedad * delta
		# Aplica gravedad solo si el jugador está en el aire

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = brinco
		# Si se presiona "ui_up" y está en el suelo, ejecuta un salto

	move_and_slide()
	# Mueve al personaje y gestiona automáticamente las colisiones

	update_animation()
	# Llama a la función que cambia la animación según el estado del jugador


# === ANIMACIONES DEL PERSONAJE ===
func update_animation():
	if not is_on_floor():
		if velocity.y <= 400:
			animated_sprite.play("jump")  # Si sube en el aire
		else:
			animated_sprite.play("fall")  # Si cae
		return

	if velocity.x != 0:
		animated_sprite.play("run")  # Si se está moviendo horizontalmente
	else:
		animated_sprite.play("idle")  # Si está quieto

	# OPCIONAL: Voltear sprite según dirección
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0


# === REINICIO AL TOCAR ÁREA DE MUERTE ===
func _on_reset_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		get_tree().reload_current_scene()
		# Reinicia el nivel actual si el jugador entra en un área peligrosa


# === CAMBIO DE NIVEL AL TOCAR PUERTA ===
func _on_puerta_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		get_tree().change_scene_to_file("res://Level2/Player/world.tscn")
		# Cambia a la siguiente escena si el jugador entra en la "puerta"
