extends Node3D

@onready var doore: CSGBox3D = $Entrance/Door
@onready var doorb: CSGBox3D = $ExitBack/Door
@onready var doorf1: CSGBox3D = $ExitFront1/Door
@onready var doorf2: CSGBox3D = $ExitFront2/Door
@onready var doorr1: CSGBox3D = $ExitRight1/Door
@onready var doorr2: CSGBox3D = $ExitRight2/Door
@onready var doorl1: CSGBox3D = $ExitLeft1/Door
@onready var doorl2: CSGBox3D = $ExitLeft2/Door

var doorepos
var doorbpos
var doorf1pos
var doorf2pos
var doorr1pos
var doorr2pos
var doorl1pos
var doorl2pos

@onready var olb: OmniLight3D = $ExitBack/OmniLight3D
@onready var olf1: OmniLight3D = $ExitFront1/OmniLight3D
@onready var olf2: OmniLight3D = $ExitFront2/OmniLight3D
@onready var olr1: OmniLight3D = $ExitRight1/OmniLight3D
@onready var olr2: OmniLight3D = $ExitRight2/OmniLight3D
@onready var oll1: OmniLight3D = $ExitLeft1/OmniLight3D
@onready var oll2: OmniLight3D = $ExitLeft2/OmniLight3D

@onready var level_3: Node3D = $Level3
@onready var level_4: Node3D = $Level4

func _ready():
	doorepos = doore.position
	doorbpos = doorb.position
	doorf1pos = doorf1.position
	doorf2pos = doorf2.position
	doorr1pos = doorr1.position
	doorr2pos = doorr2.position
	doorl1pos = doorl1.position
	doorl2pos = doorl2.position
	olb.visible = false
	olf1.visible = false
	olf2.visible = false
	olr1.visible = false
	olr2.visible = false
	oll1.visible = false
	oll2.visible = false
	level_3.position.z = 60
	
	SignalBus.close_doors.connect(transition)
	SignalBus.next_level.connect(change_doors)
	change_doors(1) # LEVEL HERE

func transition():
	doore.position = doorepos
	doorb.position = doorbpos
	doorf1.position = doorf1pos
	doorf2.position = doorf2pos
	doorr1.position = doorr1pos
	doorr2.position = doorr2pos
	doorl1.position = doorl1pos
	doorl2.position = doorl2pos
	olb.visible = false
	olf1.visible = false
	olf2.visible = false
	olr1.visible = false
	olr2.visible = false
	oll1.visible = false
	oll2.visible = false
	level_3.position.z = 60
	level_4.position.z = 60

func change_doors(level_num : int):
	match(level_num):
		1:
			doore.position.y += -10
			doorf1.position.y += -10
			olf1.visible = true
		2:
			doore.position.y += -10
			doorf2.position.y += 10
			olf2.visible = true
		3:
			level_3.position.z = 0
			doorr2.position.y += 10
			doore.position.y += -10
			olr2.visible = true
		4:
			doore.position.y += -10
			level_4.position.z = 0
			doorl1.position.y -= 10
			oll1.visible = true
		5:
			doore.position.y += -10
		6:
			doore.position.y += -10
		7:
			doore.position.y += -10
