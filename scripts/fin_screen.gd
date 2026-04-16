extends Label3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	SignalBus.fin_text.connect(_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _game_over():
	self.visible = true
