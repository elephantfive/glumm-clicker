extends Node2D
@onready var game_manager: GameManager = %GameManager
const shopbutton = preload("res://assets/gui/shop_button.tscn")
@onready var glumm_manager = %GlummManager
var unlocked_glumms = ["none"]


func _ready():
	var current_row: int = 1
	var color_rows: Dictionary[String, int]
	var color_cols: Dictionary[String, int]
	
	for upgrade:Upgrade in game_manager.global:
		if upgrade.color not in color_rows:
			color_rows[upgrade.color] = current_row
			current_row += 1
		if upgrade.color not in color_cols:
			color_cols[upgrade.color] = 1
			
	for upgrade:Upgrade in game_manager.global:
		var new_button = shopbutton.instantiate()
		new_button.shop = self
		new_button.game_manager = game_manager
		new_button.glumm_manager = glumm_manager
		new_button.posy = color_cols[upgrade.color]
		new_button.posx = color_rows[upgrade.color]
		color_cols[upgrade.color] += 1
		new_button.upgrade = upgrade
		add_child(new_button)

func _process(_delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
