extends Area2D

@onready var timer = $Timer
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/brown_projectile.tscn')
var dx = 50
var dy = 100

func _ready():
	timer.start()

func _physics_process(delta):
	global_position.x += dx * delta
	global_position.y += dy * delta
	if global_position.x <= -30 or global_position.x >= get_viewport_rect().size.x + 30 or global_position.y <= -30 or global_position.y >= get_viewport_rect().size.y + 30:
		call_deferred("queue_free")

func _on_area_entered(area: Area2D) -> void:
	area.dx = 0
	area.dy = 0

func _on_timer_timeout():
	var bullet = proj_scene.instantiate()
	bullet.position.x = position.x + randi_range(-20, 20)
	bullet.position.y = position.y + randi_range(0, 20)
	bullet.projectile_holder = projectile_holder
	projectile_holder.call_deferred("add_child", bullet)
