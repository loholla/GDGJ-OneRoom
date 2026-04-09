extends Control

@onready var _flipped_image: TextureRect = $Flipped # 1
@onready var _normal_image: TextureRect = $Normal # 2

var img = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_flipped_image.visible = false
	SignalBus.flip_icon.connect(_flip_icon)
	SignalBus.flip_now.connect(_reset)


func _flip_icon():
	if img == 2:
		_normal_image.visible = false
		_flipped_image.visible = true
		img = 1
	else:
		_normal_image.visible = true
		_flipped_image.visible = false
		img = 2

func _reset():
	_normal_image.visible = true
	_flipped_image.visible = false
	img = 2
