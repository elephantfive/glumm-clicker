extends Node2D
var game_manager: Node
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/orange_projectile.tscn')
@onready var timer = $Timer
@onready var glumm = $glumm

func _ready():
	timer.start()

func _on_glumm_clicked() -> void:
	for i in 4:
		var bullet = proj_scene.instantiate()
		bullet.current_speed = i
		bullet.position = glumm.position
		bullet.game_manager = game_manager
		bullet.projectile_holder = projectile_holder
		projectile_holder.call_deferred("add_child", bullet)


func _on_timer_timeout():
	glumm.dx = randf_range(glumm.speedmin, glumm.speedmax)
	glumm.dy = randf_range(glumm.speedmin, glumm.speedmax)
