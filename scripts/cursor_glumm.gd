extends Area2D
@onready var game_manager: Node = %GameManager

func _process(_delta):
	scale = Vector2(float(game_manager.global["Cursor Size"]) / 10.0, float(game_manager.global["Cursor Size"]) / 10.0)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_position(get_viewport().get_mouse_position())
