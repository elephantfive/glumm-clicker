extends Node2D
var game_manager: Node
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/white_projectile.tscn')
@onready var glumm = $glumm

func _ready():
	var nums = [-600, 600]
	glumm.dx = nums[randi() % nums.size()]
	glumm.dy = nums[randi() % nums.size()]

func _on_glumm_clicked() -> void:
	for i in 8:
		var bullet = proj_scene.instantiate()
		bullet.current_speed = i
		bullet.position = glumm.position
		bullet.game_manager = game_manager
		projectile_holder.call_deferred("add_child", bullet)
		
