extends Node3D

@onready var _beginning: Area3D = $"../RoomCore/Entrance/InRoomBegin"
@onready var _transitional: Area3D = $InRoomT
@onready var _exitb: Area3D = $"../RoomCore/ExitBack/InRoomB"
@onready var _exitf1: Area3D = $"../RoomCore/ExitFront1/InRoomF1"
@onready var _exitf2: Area3D = $"../RoomCore/ExitFront2/InRoomF2"
@onready var _exitr1: Area3D = $"../RoomCore/ExitRight1/InRoomR1"
@onready var _exitr2: Area3D = $"../RoomCore/ExitRight2/InRoomR2"
@onready var _exitl1: Area3D = $"../RoomCore/ExitLeft1/InRoomL1"
@onready var _exitl2: Area3D = $"../RoomCore/ExitLeft2/InRoomL2"


func _ready():
	_beginning.body_entered.connect(_be)
	_beginning.body_exited.connect(_bl)
	_exitb.body_entered.connect(_ebe)
	_exitb.body_exited.connect(_ebl)
	_exitf1.body_entered.connect(_ef1e)
	_exitf1.body_exited.connect(_ef1l)
	_exitf2.body_entered.connect(_ef2e)
	_exitf2.body_exited.connect(_ef2l)
	_exitl1.body_entered.connect(_el1e)
	_exitl1.body_exited.connect(_el1l)
	_exitl2.body_entered.connect(_el2e)
	_exitl2.body_exited.connect(_el2l)
	_exitr1.body_entered.connect(_er1e)
	_exitr1.body_exited.connect(_er1l)
	_exitr2.body_entered.connect(_er2e)
	_exitr2.body_exited.connect(_er2l)
	_transitional.body_entered.connect(_te)
	_transitional.body_exited.connect(_tl)

func _be(body):
	if body.is_in_group("player"):
		GameManager.begin = true

func _bl(body):
	if body.is_in_group("player"):
		GameManager.begin = false

func _ebe(body):
	if body.is_in_group("player"):
		GameManager.eb = true

func _ebl(body):
	if body.is_in_group("player"):
		GameManager.eb = false

func _ef1e(body):
	if body.is_in_group("player"):
		GameManager.ef1 = true

func _ef1l(body):
	if body.is_in_group("player"):
		GameManager.ef1 = false

func _ef2e(body):
	if body.is_in_group("player"):
		GameManager.ef2 = true

func _ef2l(body):
	if body.is_in_group("player"):
		GameManager.ef2 = false

func _el1e(body):
	if body.is_in_group("player"):
		GameManager.el1 = true

func _el1l(body):
	if body.is_in_group("player"):
		GameManager.el1 = false

func _el2e(body):
	if body.is_in_group("player"):
		GameManager.el2 = true

func _el2l(body):
	if body.is_in_group("player"):
		GameManager.el2 = false

func _er1e(body):
	if body.is_in_group("player"):
		GameManager.er1 = true

func _er1l(body):
	if body.is_in_group("player"):
		GameManager.er1 = false

func _er2e(body):
	if body.is_in_group("player"):
		GameManager.er2 = true

func _er2l(body):
	if body.is_in_group("player"):
		GameManager.er2 = false

func _te(body):
	if body.is_in_group("player"):
		GameManager.trans = true

func _tl(body):
	if body.is_in_group("player"):
		GameManager.trans = false
