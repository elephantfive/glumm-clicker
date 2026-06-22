class_name Upgrade

extends Resource

@export var parameter_name: String

@export var unlocked: bool

@export var default_price: int
var price: int = default_price
@export var price_increment: int

@export var modified_glumm: String
@export var modified_attribute: String
@export var modified_increment: int

@export var default_value: int
var current_value: int = default_value
@export var max_price_value: int


var saved_vals = ["unlocked", "price", "current_value"]
