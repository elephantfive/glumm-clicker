extends Area2D
var game_manager: Node
var bounce: int = 0
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/orange_projectile.tscn')
var projectile_bounce: int
var speeds = {
	'0' = [600, -600],
	'1' = [600, 600],
	'2' = [-600, 600],
	'3' = [-600, -600],
}
var current_speed: int
var dx: int
var dy: int

func _ready():
	dx = speeds[str(current_speed)][0]
	dy = speeds[str(current_speed)][1]

func _physics_process(delta):
	global_position.x += dx * delta
	global_position.y += dy * delta
	if global_position.x <= -30 or global_position.x >= get_viewport_rect().size.x + 30 or global_position.y <= -30 or global_position.y >= get_viewport_rect().size.y + 30:
		call_deferred("queue_free")

func _on_area_entered(_area: Area2D) -> void:
	if bounce < projectile_bounce:
		bounce += 1
		for i in 4:
			var bullet = proj_scene.instantiate()
			bullet.current_speed = i
			bullet.position = position
			bullet.projectile_bounce = projectile_bounce
			bullet.bounce = bounce
			bullet.game_manager = game_manager
			bullet.projectile_holder = projectile_holder
			projectile_holder.call_deferred("add_child", bullet)
	else:
		queue_free()
