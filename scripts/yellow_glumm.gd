extends Node2D
var game_manager: Node
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/yellow_projectile.tscn')
@onready var glumm = $glumm

func _ready():
	glumm.dy = 1000
	glumm.dx = randi_range(-60, 60)
	
func _on_glumm_clicked() -> void:
	var available = [1, 2, 3, 4, 5]
	for i in game_manager.global["Yellow Projectiles"]:
		var chosen_num = available.pick_random()
		var bullet = proj_scene.instantiate()
		bullet.position.x = chosen_num * 400 + 150
		bullet.position.y = 0
		available.erase(chosen_num)
		projectile_holder.call_deferred("add_child", bullet)
