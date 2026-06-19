extends GlummBody

func _ready():
	startup()
	dy = randi_range(-60, 60)
	dx = 1000
	start_dy = dy
	start_dx = dx
	
func glumm_click():
	var bullet = proj_scene.instantiate()
	bullet.position = position
	bullet.projectile_holder = projectile_holder
	projectile_holder.call_deferred("add_child", bullet)
