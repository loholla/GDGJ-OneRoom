extends CharacterBody3D

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var raycast: RayCast3D = $Head/RayCast3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var sensitivity = 0.005

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	SignalBus.set_position.connect(level_trans)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

# Most of this section was added by the template used. Any function calls are written by me
func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if is_instance_valid(coll):
			if coll.is_in_group("to_transition"):
				SignalBus.look_at_transition.emit(true)
			elif coll.is_in_group("to_start"):
				SignalBus.look_at_start.emit(true)
			elif coll.is_in_group("begin"):
				SignalBus.look_at_beginning.emit(true)
			else:
				SignalBus.look_at_start.emit(false)
				SignalBus.look_at_transition.emit(false)
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("flip"):
		SignalBus.flip_room.emit()

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	#Head Bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()

func _headbob(time):
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func level_trans(x,y,z, rotation_in):
	position.x = x
	position.y = y
	position.z = z
	head.rotation.y = rotation_in
