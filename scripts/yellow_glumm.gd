extends GlummBody


func _ready():
	dy = 1000
	dx = randi_range(-60, 60)
	startup()
	
func glumm_click():
	var available = [1, 2, 3, 4, 5]
	for i in modified_values['proj_count'].current_value:
		var chosen_num = available.pick_random()
		var bullet = proj_scene.instantiate()
		bullet.position.x = chosen_num * 400 + 150
		bullet.position.y = 0
		available.erase(chosen_num)
		projectile_holder.call_deferred("add_child", bullet)
