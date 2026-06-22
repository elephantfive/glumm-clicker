extends Timer
@onready var glumm_manager: Node2D = $".."
@export var glumm: Upgrade
@export var glumm_type: String

func _ready():
	wait_time += randf_range(-1, 3)

func _on_timeout() -> void:
	if "friend" in glumm_type or "enemy" in glumm_type:
		glumm_manager.glummi += 1
		glumm_manager.glumms[glumm_type + str(glumm_manager.glummi)] = null
	elif glumm.current_value == 1:
		glumm_manager.glummi += 1
		glumm_manager.glumms[glumm.color.replace(" ", "").to_lower() + str(glumm_manager.glummi)] = null
