extends GlummBody

func _ready():
	var nums = [-600, 600]
	dx = nums[randi() % nums.size()]
	dy = nums[randi() % nums.size()]
	startup()

func glumm_click():
	for i in 8:
		var bullet = proj_scene.instantiate()
		bullet.current_speed = i
		bullet.position = position
		bullet.game_manager = game_manager
		projectile_holder.call_deferred("add_child", bullet)
		
