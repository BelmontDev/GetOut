extends CharacterBody2D

var speed := 150
var direccion := 0.0
var jump := 300
var points = 0
const gravity := 10

@onready var anim := $AnimatedSprite2D

var was_on_floor := false
var landing_timer := 0.0  # Temporizador para la animación de aterrizaje
var landing_duration := .2  # Duración de la animación de aterrizaje (2 segundos)

func _physics_process(delta: float) -> void:
	direccion = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccion * speed

	# Si la animación de aterrizaje está en curso, mantenemos el temporizador
	if landing_timer > 0:
		landing_timer -= delta  # Reducimos el temporizador
		if landing_timer <= 0:
			anim.play("Idle" if direccion == 0 else "Walk")  # Pasar a la animación de idle o walk
			landing_timer = 0  # Reiniciamos el temporizador

	# Animaciones mientras está en el aire o en el suelo
	if not is_on_floor():
		anim.play("Jump")  # Mientras esté en el aire
	elif direccion != 0 and landing_timer <= 0:
		anim.play("Walk")
	elif landing_timer <= 0:
		anim.play("Idle")

	# Flip de la animación dependiendo de la dirección
	anim.flip_h = direccion < 0 if direccion != 0 else anim.flip_h

	# Salto
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
		anim.play("Jump")

	# Aceleración de gravedad
	if not is_on_floor():
		velocity.y += gravity

	# Verificar si acaba de aterrizar
	if is_on_floor() and not was_on_floor and landing_timer <= 0:
		anim.play("Land")  # Reproducir la animación de aterrizaje
		landing_timer = landing_duration  # Activar el temporizador de aterrizaje
	was_on_floor = is_on_floor()

	move_and_slide()
	
	
func Pickup_Gem():
	points += 1
	get_node("/root/World/HUD").update_count(points)
