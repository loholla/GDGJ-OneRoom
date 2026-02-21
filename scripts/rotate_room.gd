extends Node3D

@onready var room_core: Node3D = $RoomCore

var rotation_time = 5
var rotating := false
var start_rotation : float
var target_rotation : float
var elapsed_time := 0.0
var initial_rotation : float

func _ready():
	initial_rotation = room_core.rotation.x
	SignalBus.flip_room.connect(_smooth_flip)
	SignalBus.flip_now.connect(_reset_flip)

func _smooth_flip():
	if not rotating and GameManager.level != 1 and GameManager.in_level:
		print("Rotating")
		rotating = true
		elapsed_time = 0.0
		start_rotation = room_core.rotation.x
		
		var direction = -1.0 if GameManager.reverse_flip else 1.0
		target_rotation = start_rotation + (PI * direction)

func _reset_flip():
	rotating = false
	room_core.rotation.x = initial_rotation

func _physics_process(delta):
	if not rotating:
		return
	
	elapsed_time += delta
	var weight = clamp(elapsed_time / rotation_time, 0.0, 1.0)
	
	room_core.rotation.x = lerp_angle(start_rotation, target_rotation, weight)
	
	if weight >= 1.0:
		room_core.rotation.x = target_rotation
		rotating = false
