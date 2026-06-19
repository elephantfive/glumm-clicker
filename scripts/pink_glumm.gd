extends Node2D
var projectile_holder: Node
var game_manager: Node
var proj_scene = preload('res://assets/projectiles/pink_projectile.tscn')
@onready var glumm = $glumm


func _on_glumm_clicked() -> void:
	var bullet = proj_scene.instantiate()
	bullet.position = get_child(0).position
	bullet.game_manager = game_manager
	projectile_holder.call_deferred("add_child", bullet)
