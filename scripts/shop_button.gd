extends Button
@export var posx: int
@export var posy: int
@onready var label = $Label
@onready var animated_sprite_2d = $AnimatedSprite2D
var offset: float = 0
var upgrade: Upgrade
var unlocked_glumms = ['none']
@onready var game_manager: GameManager
var glumm_manager: Node2D

func _ready():
	for unlock in game_manager.global:
		if unlock.new_glumm_unlock:
			if unlock.current_value > unlock.default_value:
				unlocked_glumms.append(unlock.color)
	position.x = 100 + (posx - 1) * 300
	position.y = posy * 200

func _physics_process(delta):
	max_check()
	if not disabled:
		var frame = animated_sprite_2d.get_frame()
		if upgrade.new_glumm_unlock:
			label.text = (upgrade.text + "\n" + "\nPrice: " + str(upgrade.price))
		else:
			label.text = (upgrade.text + "\n" + "Current value: " + str(upgrade.current_value) + "\nCurrent Price: " + str(upgrade.price))
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
	if game_manager.score >= upgrade.price:
		if upgrade.new_glumm_unlock:
			glumm_manager.glummgen(upgrade.color)
		game_manager.score -= upgrade.price
		upgrade.price += upgrade.price_increment
		upgrade.current_value += upgrade.modified_increment
		
		#upgrade.modified_glumm.set(upgrade.modified_attribute, upgrade.current_value)
		if upgrade.color not in unlocked_glumms:
			unlocked_glumms.append(upgrade.color)
		max_check()

func max_check():
	if upgrade.color in unlocked_glumms:
		upgrade.unlocked = true
		
	if upgrade.unlocked and upgrade.current_value < upgrade.max_value:
		enable_button()
	else:
		disable_button()


func disable_button():
	label.text = ""
	disabled = true
	get_child(0).self_modulate = Color(0.5, 0.5, 0.5, 0.5)

func enable_button():
	disabled = false
	get_child(0).self_modulate = Color(0.3, 0.19, 0.06, 1.00)
