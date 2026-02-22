extends Node

# Walls that the player needs to be up against
var eb : bool = false
var ef1 : bool = false
var ef2 : bool = false
var el1 : bool = false
var el2 : bool = false
var er1 : bool = false
var er2 : bool = false
var trans : bool = false
var begin : bool = false

# If the raycast is hitting a certain wall
var l_at_transition : bool = false
var l_at_start : bool = false
var l_at_begin : bool = false

# Rotational stuff
var flipped : bool = false
var reverse_flip := false

var level := 1
var ready_to_progress := false
var in_level := true

func _ready():
	SignalBus.look_at_start.connect(las)
	SignalBus.look_at_transition.connect(lat)
	SignalBus.flip_room.connect(flip)
	SignalBus.look_at_beginning.connect(lab)

func las(val):
	l_at_start = val

func lat(val):
	l_at_transition = val

func lab(val):
	l_at_begin = val

func flip():
		flipped = !flipped
		match(level):
			3:
				if not flipped:
					reverse_flip = false
				else:
					reverse_flip = true
			4:
				reverse_flip = true
			_:
				reverse_flip = false
		SignalBus.smooth_rotate.emit()

func _physics_process(_delta):
	if (eb or ef1 or ef2 or er1 or er2 or el1 or el2) and l_at_transition:
		print("Teleport to Transition Room")
		in_level = false
		SignalBus.set_position.emit(34.0,17.5,0, -1.5)
		SignalBus.close_doors.emit()
		SignalBus.flip_now.emit()
	elif trans and l_at_start:
		print("Teleport to Start Room")
		ready_to_progress = true
		SignalBus.set_position.emit(17.5,1,0, 1.5)
	elif begin and l_at_begin and ready_to_progress:
		print("Begin Next Level")
		in_level = true
		ready_to_progress = false
		level += 1
		SignalBus.next_level.emit(level)
