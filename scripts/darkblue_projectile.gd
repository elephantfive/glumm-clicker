extends Area2D
func isBlueProj():
	pass
@onready var timer = $Timer
var projectile_holder: Node
var proj_scene = preload('res://assets/projectiles/darkblue_projectile.tscn')
var dx = 200
var dy = 200
var dir: int
var blueiter: int

func _ready():
	if dir == 1:
		dx = -dx
		rotation = PI / 2
	elif dir == 2:
		dy = -dy
		rotation = PI / 2
	elif dir == 3:
		dx = -dx
		dy = -dy
	timer.start()

func _physics_process(delta):
	global_position.x += dx * delta
	global_position.y += dy * delta
	if global_position.x <= -30 or global_position.x >= get_viewport_rect().size.x + 30 or global_position.y <= -30 or global_position.y >= get_viewport_rect().size.y + 30:
		queue_free()

func _on_area_entered(_area: Area2D) -> void:
	var blue_children = projectile_holder.get_children()
	for child in blue_children:
		if child.has_method('isBlueProj'):
			if child.blueiter == blueiter:
				child.queue_free()
	var bullet = proj_scene.instantiate()
	bullet.position.x = position.x + dx / 6.0
	bullet.position.y = position.y + dy / 6.0
	bullet.projectile_holder = projectile_holder
	bullet.dir = randi_range(0, 3)
	bullet.blueiter = blueiter
	projectile_holder.call_deferred("add_child", bullet)
	queue_free()

func _on_timer_timeout():
	var bullet = proj_scene.instantiate()
	bullet.position.x = position.x + dx / 6.0
	bullet.position.y = position.y + dy / 6.0
	bullet.projectile_holder = projectile_holder
	bullet.dir = dir
	bullet.blueiter = blueiter
	projectile_holder.call_deferred("add_child", bullet)
