extends Area2D
var game_manager: Node
@onready var timer = $Timer

func _ready():
	timer.start()

func _on_timer_timeout():
	var particle_scene = preload("res://scenes/pink_particles.tscn")
	var particles = particle_scene.instantiate()
	particles.position = position
	particles.set_deferred('emitting', true)
	game_manager.add_child(particles)
	queue_free()
