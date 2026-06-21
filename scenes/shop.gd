extends Node2D
@onready var game_manager = %GameManager
const shopbutton = preload("res://assets/gui/shop_button.tscn")
@onready var cursor_button = $CursorButton
@onready var white_projectile_pierce_button: Button = $WhiteProjectilePierceButton

	
func _process(_delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
