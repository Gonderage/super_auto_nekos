extends TextureRect

var start_position : Vector2

signal released

func _ready():
	start_position = position

func _input(event):
	if event is InputEventMouseMotion:
		position = event.global_position - (size/2)
	elif (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.is_released()):
			# Legend tell of a spooky ghost appearing at event.global_position
			# when finished tweening if process_input is left true...
			set_process_input(false)
			var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "position", start_position, 0.3)
			tween.tween_callback(_on_released)

func _on_released():
	released.emit()
	queue_free()
