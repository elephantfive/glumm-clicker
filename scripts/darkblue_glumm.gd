extends GlummBody


func glumm_click():
	var bullet = proj_scene.instantiate()
	bullet.position = position
	bullet.projectile_holder = projectile_holder
	if position.x > get_viewport_rect().size.x / 2:
		if position.y > get_viewport_rect().size.y / 2:
			bullet.dir = 3
		else:
			bullet.dir = 1
	else:
		if position.y > get_viewport_rect().size.y / 2:
			bullet.dir = 2
		else:
			bullet.dir = 0
	bullet.blueiter = randi_range(0, 100000)
	projectile_holder.call_deferred("add_child", bullet)	

func _on_timer_timeout():
	position.x = randf_range(WIDTH, get_viewport_rect().size.x)
	position.y = randf_range(HEIGHT, get_viewport_rect().size.y)
	dx = randf_range(speedmin, speedmax)
	dy = randf_range(speedmin, speedmax)
