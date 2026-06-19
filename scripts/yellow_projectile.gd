extends Area2D
var dy = 600

func _physics_process(delta):
	global_position.y += dy * delta
	if global_position.y >= get_viewport_rect().size.y + 600:
		call_deferred("queue_free")
