extends Area2D
var game_manager: Node

var pierce = 0
var speeds = {
	'0' = [600, 600],
	'1' = [600, 0],
	'2' = [600, - 600],
	'3' = [0, 600],
	'4' = [0, -600],
	'5' = [-600, -600],
	'6' = [-600, 0],
	'7' = [-600, 600],
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
	if pierce == game_manager.global['White Projectile Pierce']:
		call_deferred("queue_free")
	else:
		pierce += 1
