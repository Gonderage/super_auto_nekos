# ENSURE: MenuControl manages the control nodes, not gameplay
extends Control

@export var max_units := 5

var units : Array[Unit]
var team_container : HBoxContainer
var shop_container : HBoxContainer

func _ready():
	# Now you can rename AND reorder the container containing units!!
	for c in get_children():
		if c is SplitContainer:
			team_container = c.get_child(0)
			shop_container = c.get_child(1)

func _input(event):
	if (event is InputEventKey and event.is_released()
		and units.size() <= max_units - 1): # wtf why is size() always one more?
		var new_unit := Unit.new(
			preload("res://assets/resources/neko_arc.tres"),
			Color(
				randf_range(0,1),
				randf_range(0,1),
				randf_range(0,1)
				)
			)
		team_container.add_child(new_unit)
		units.append(new_unit)
