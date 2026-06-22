class_name Upgrade

extends Resource

@export var parameter_name: String
@export var text: String
@export var unlocked: bool = false

@export var new_glumm_unlock: bool
@export var color: String

@export var default_price: int
var price: int = default_price
@export var price_increment: int

@export var modified_increment: int
@export var default_value: int
@export var max_value: int
var current_value: int = default_value


var saved_vals = ["unlocked", "price", "current_value"]
