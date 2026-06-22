extends Node2D
@onready var game_manager: GameManager = %GameManager
const shopbutton = preload("res://assets/gui/shop_button.tscn")

func _ready():
	var current_row: int = 1
	var colors: Dictionary[String, int]
	
	for upgrade:Upgrade in game_manager.global:
		if upgrade.color not in colors:
			colors[upgrade.color] = current_row
			current_row += 1
			
	for upgrade:Upgrade in game_manager.global:
		var current_col: int = 1
		var new_button = shopbutton.instantiate()
		new_button.posx = current_row
		new_button.posy = current_col
		add_child(new_button)

func _process(_delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
