## Base class for a unit
# TODO: Separate UI functionality from gameplay logic.
# TODO: Separate texture into a separate node for graphics
@icon("res://assets/img/sword.svg")
class_name Unit
extends TextureRect

@export var unit_data : UnitData
@export_range(1,99,1,"suffix:HP") var health : int = 1
@export_range(1,99,1,"suffix:AP") var attack : int = 1
@export_range(1,99,1) var tier : int = 1
@export_range(1,99,1,"suffix:$") var buy : int = 3
@export_range(1,99,1,"suffix:$") var sell : int = 1

var random_color : Color
var selected := false
var tween : Tween

@onready var shadow_script : Script = preload("res://assets/scripts/unit_shadow.gd")

func _ready():
	mouse_entered.connect(highlight)
	mouse_exited.connect(unhighlight)
	expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL

func _init(data : UnitData, color := Color.WHITE):
	unit_data = data
	health = data.health
	attack = data.attack	
	tier = data.tier
	buy = data.buy
	sell = data.sell
	texture = data.texture
	random_color = color
	modulate = random_color

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			create_shadow()

func _on_shadow_release():
	modulate = random_color
	selected = false

func highlight():
	if selected == false:
		tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "modulate", Color(1.1, 1.1, 1.1), 0.18)

func unhighlight():
	if selected == false:
		tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "modulate", random_color, 0.18)

func create_shadow():
	var shadow := TextureRect.new()
	shadow.position = global_position
	shadow.modulate = random_color
	shadow.texture = texture
	shadow.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	shadow.size = size
	shadow.set_script(shadow_script)
	shadow.released.connect(_on_shadow_release)
	get_window().add_child(shadow) # Dont add to MenuControl to avoid weird stuff
	if tween.is_running(): tween.kill()
	self.modulate = Color.BLACK
	selected = true
