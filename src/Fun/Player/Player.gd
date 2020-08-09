extends KinematicBody

export var sensitivity: float = 5
export var speed: float = 10
onready var camera: Camera = $Camera


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_viewport().warp_mouse(get_viewport().size * 0.5)


func _process(delta: float) -> void:
	# ROTATE
	# get mouse speed
	var mouse_speed = _get_mouse_speed()
	# move camera
	rotate_y(mouse_speed.x * sensitivity * delta)
	camera.rotate_x(mouse_speed.y * sensitivity * delta * 0.5)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -30, 30)
	# zero mouse position
	get_viewport().warp_mouse(get_viewport().size * 0.5)
	# MOVE
	var velocity = Vector3()
	velocity += transform.basis.z * (Input.get_action_strength("back") - Input.get_action_strength("forward"))
	velocity += transform.basis.x * (Input.get_action_strength("right") - Input.get_action_strength("left"))
	move_and_slide(velocity * speed)

func _get_mouse_speed() -> Vector2:
	return get_viewport().size * 0.5 - get_viewport().get_mouse_position()
