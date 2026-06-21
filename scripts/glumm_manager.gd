extends Node
@onready var game_manager: Node = %GameManager
@onready var friend_timer: Timer = $FriendTimer
@onready var projectile_holder = $"../ProjectileHolder"
var glumms = {}
var glummi = 0
var glummtimers = {}

func _ready():
	glumms['friend0'] = null
	glumms['enemy0'] = null

func _process(_delta):
	for key in glumms:
		if glumms[key] == null:
			glumms[key] = glummgen(key.rstrip('0123456789'))
			
	

func glummgen(variant):
	var glumm_scene = load('res://assets/entities/' + str(variant) + '_glumm.tscn')
	var new_obj = glumm_scene.instantiate()
	new_obj.game_manager = game_manager
	new_obj.projectile_holder = projectile_holder
	add_child(new_obj)
	return new_obj
	
