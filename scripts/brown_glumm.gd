extends Node2D
var game_manager: Node
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/brown_projectile.tscn')
@onready var glumm = $glumm

func _ready():
	glumm.dy = randi_range(-60, 60)
	glumm.dx = 1000
	
func _on_glumm_clicked() -> void:
	var bullet = proj_scene.instantiate()
	bullet.position = glumm.position
	bullet.projectile_holder = projectile_holder
	projectile_holder.call_deferred("add_child", bullet)	
