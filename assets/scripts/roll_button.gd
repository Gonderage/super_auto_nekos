## Roll button functionality
extends Button

var unit_types : Array

@onready var shop : HBoxContainer = %ShopContainer
@onready var units : PackedStringArray = DirAccess.open("res://assets/units/").get_files()

func _ready() -> void:
#	for u in units.size():
#		var u_name = units[0].trim_suffix(".tres")
#		units.set(u, u_name)
	print(units)

func _on_pressed():
	# TODO: Add animation component and connect it to on_pressed (the animation component should spin the icon ^_^)
	var new_unit := pick_random_unit()
	shop.add_child(new_unit)

# TODO: Find an appropriate randomizing algorithm
# ENSURE: The randomizing algorithm must weight unit probability by tier and by the status of the player, team, and shop
func pick_random_unit() -> Unit:
	var random_index := randi_range(0, units.size()-1)
	var data : UnitData = load("res://assets/units/" + units[random_index])
	return Unit.new(data)
