extends GlummBody
var angle: float = 0
var radius: float = 5

func _physics_process(delta):
	if global_position.x <= -WIDTH * 4 or global_position.x >= get_viewport_rect().size.x + WIDTH * 4 or global_position.y <= -HEIGHT or global_position.y >= get_viewport_rect().size.y + WIDTH * 4:
		respawn()
	if explode:
		if Input.is_action_just_pressed("click"):
			boom.emit()
	if get("visible"):
		dx = cos(angle) * radius / delta
		dy = sin(angle) * radius / delta
		radius += delta
		if angle < 6.28:
			angle += 2 * delta
		else:
			angle = 0 
		global_position.x += dx * delta
		global_position.y += dy * delta

func respawn():
	set_random_pos()
	angle = 0
	radius = 5
	dx = start_dx
	dy = start_dy
	toggle_active(true)

func glumm_click():
	var bullet = proj_scene.instantiate()
	bullet.position = position
	bullet.game_manager = game_manager
	projectile_holder.call_deferred("add_child", bullet)
