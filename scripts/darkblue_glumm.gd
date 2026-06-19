extends Node2D
var game_manager: Node
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/darkblue_projectile.tscn')
@onready var timer = $Timer
@onready var glumm = $glumm

func _ready():
	timer.start()

func _on_glumm_clicked() -> void:
	var bullet = proj_scene.instantiate()
	bullet.position = glumm.position
	bullet.projectile_holder = projectile_holder
	if glumm.position.x > get_viewport_rect().size.x / 2:
		if glumm.position.y > get_viewport_rect().size.y / 2:
			bullet.dir = 3
		else:
			bullet.dir = 1
	else:
		if glumm.position.y > get_viewport_rect().size.y / 2:
			bullet.dir = 2
		else:
			bullet.dir = 0
	bullet.blueiter = randi_range(0, 100000)
	projectile_holder.call_deferred("add_child", bullet)	

func _on_timer_timeout():
	glumm.position.x = randf_range(glumm.WIDTH, get_viewport_rect().size.x)
	glumm.position.y = randf_range(glumm.HEIGHT, get_viewport_rect().size.y)
	glumm.dx = randi_range(glumm.speedmin, glumm.speedmax)
	glumm.dy = randi_range(glumm.speedmin, glumm.speedmax)
