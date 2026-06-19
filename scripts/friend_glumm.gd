extends Node2D
var game_manager: Node
var projectile_holder: Node

func _on_glumm_clicked() -> void:
	game_manager.global["Score"] += 1
