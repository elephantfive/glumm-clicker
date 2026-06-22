extends Area2D
@onready var game_manager: GameManager = %GameManager

func _process(_delta):
	var cursor_size
	for upgrade:Upgrade in game_manager.global:
		if upgrade.parameter_name == "Cursor Size":
			cursor_size = upgrade.current_value
	scale = Vector2(float(cursor_size) / 10.0, float(cursor_size) / 10.0)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_position(get_viewport().get_mouse_position())
