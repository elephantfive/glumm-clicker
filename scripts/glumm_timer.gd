extends Timer
@onready var glumm_manager: Node2D = $".."
@export var glumm: String

func _ready():
	wait_time += randf_range(-1, 3)

func _on_timeout() -> void:
	if "friend" in glumm or "enemy" in glumm:
		glumm_manager.glummi += 1
		glumm_manager.glumms[glumm + str(glumm_manager.glummi)] = null
	else:
		for key in glumm_manager.game_manager.global:
			if ((glumm + " Glumm Unlocked") in key and glumm_manager.game_manager.global[key] == 1):
				glumm_manager.glummi += 1
				glumm_manager.glumms[glumm.replace(" ", "").to_lower() + str(glumm_manager.glummi)] = null
