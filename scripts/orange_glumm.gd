extends GlummBody

func glumm_click():
	for i in 4:
		var bullet = proj_scene.instantiate()
		bullet.current_speed = i
		bullet.position = position
		bullet.game_manager = game_manager
		bullet.projectile_holder = projectile_holder
		projectile_holder.call_deferred("add_child", bullet)


func _on_timer_timeout():
	dx = randf_range(speedmin, speedmax)
	dy = randf_range(speedmin, speedmax)
