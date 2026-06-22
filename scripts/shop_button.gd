extends Button
@export var parameter: String
@export var parameter_text: String
@export var parameter_increment: int
@export var parameter_max: int
@export var posx: int
@export var posy: int
@export var price: int
@export var glumm_spawn: String
@onready var label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D
var offset: float = 0
@onready var game_manager: GameManager = %GameManager
@onready var glumm_manager = %GlummManager

func _ready():
	position.x = 100 + (posx - 1) * 300
	position.y = posy * 200

func _physics_process(delta):
	max_check()
	if not disabled:
		var frame = animated_sprite_2d.get_frame()
		if "Glumm" in parameter_text:
			label.text = (parameter_text + "\n" + "\nPrice: " + str(price))
		else:
			pass
			#price = game_manager.global[parameter] * 10
			#label.text = (parameter_text + "\n" + "Current value: " + str(game_manager.global[parameter]) + "\nCurrent Price: " + str(price))
		if frame == 0:
			offset = -0.4
		elif frame == 40:
			offset = 0.4
		elif frame < 40:
			offset -= delta
		elif frame > 40:
			offset += delta
		label.position.x += offset * 0.5
		label.position.y += offset * 0.5

func _on_pressed() -> void:
	if game_manager.score >= price:
		if glumm_spawn != "":
			glumm_manager.glummgen(glumm_spawn)
		game_manager.score -= price
		game_manager.score += parameter_increment
		max_check()

func max_check():
	for upgrade:Upgrade in game_manager.global:
		var color: String
		
	
	#for unlock in game_manager.global:
		#var color: String
		#if "Unlocked" in unlock:
			#color = unlock.trim_suffix(" Glumm Unlocked")
			#if color in parameter and "Unlocked" not in parameter:
				#if game_manager.global[unlock] != 1:
					#disable_button()
				#else:
					#enable_button()
	#if game_manager.global[parameter] >= parameter_max:
		#disable_button()

func disable_button():
	label.text = ""
	disabled = true
	get_child(0).self_modulate = Color(0.5, 0.5, 0.5, 0.5)

func enable_button():
	disabled = false
	get_child(0).self_modulate = Color(0.3, 0.19, 0.06, 1.00)
