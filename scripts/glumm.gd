class_name GlummBody

extends Area2D


@export var col: Color
@export var proj_scene: PackedScene
@export var type: String
@export var speedmin:float = -600
@export var speedmax:float = 600
@export var respawnmin = 5
@export var respawnmax = 10

@onready var burst_player = $AudioStreamPlayer2D
@onready var glumm_respawn_timer: Timer = $glumm_respawn_timer

signal clicked
signal boom

const WIDTH = 30
const HEIGHT = 30

var game_manager: GameManager
var projectile_holder: Node
var explode = false
var dx = randf_range(speedmin, speedmax)
var dy = randf_range(speedmin, speedmax)
var start_dx
var start_dy


func _ready():
	startup()

func startup():
	start_dx = dx
	start_dy = dy
	modulate = col
	glumm_respawn_timer.set_wait_time(randf_range(respawnmin, respawnmax) + randf_range(-2, 4))
	set_random_pos()

func set_random_pos():
	global_position.x = randf_range(WIDTH, get_viewport_rect().size.x)
	global_position.y = randf_range(HEIGHT, get_viewport_rect().size.y)

func _physics_process(delta):
	if global_position.x <= WIDTH:
		dx = -dx
		global_position.x += 2
	if global_position.x >= get_viewport_rect().size.x - WIDTH:
		dx = -dx
		global_position.x -= 2
	if global_position.y <= HEIGHT:
		dy = -dy
		global_position.y += 2
	if global_position.y >= get_viewport_rect().size.y - WIDTH:
		dy = -dy
		global_position.y -= 2
	if explode:
		if Input.is_action_just_pressed("click"):
			boom.emit()
	global_position.x += dx * delta
	global_position.y += dy * delta
		
func _on_area_entered(area: Area2D) -> void:
	var layer = area.get_collision_layer()
	if layer == 2:
		explode = true
	elif layer == 1 and area.type != 'enemy':
		if game_manager.score > 0:
			game_manager.score -= 1
		area.glumm_die()
	elif layer == 1 and type == 'enemy' and area.type == 'enemy':
		pass
	else:
		boom.emit()
		
func _on_area_exited(_area: Area2D) -> void:
	explode = false

func _on_boom() -> void:
	glumm_die()
	clicked.emit()
	
func glumm_die():
	burst_player.play()
	var particle_scene = preload("res://scenes/glumm_particles.tscn")
	var particles = particle_scene.instantiate()
	particles.position = position
	particles.set_deferred('emitting', true)
	get_parent().get_parent().add_child(particles)
	toggle_active(false)
	explode = false
	glumm_respawn_timer.start()


func _on_glumm_respawn_timer_timeout():
	respawn()

func respawn():
	set_random_pos()
	dx = start_dx
	dy = start_dy
	toggle_active(true)


func toggle_active(active:bool):
	set_deferred("visible", active)
	set_deferred("monitorable", active)
	set_deferred("monitoring", active)


func _on_clicked():
	glumm_click()
	
func glumm_click():
	pass
