extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _gui_input(event):
		
	if event is InputEventMouseButton:		
		# open the menu
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			var m = get_local_mouse_position()
			# Pass the center position to open_menu as a Vector2!
			$RadialMenu.open_menu(m)
			# Make sure we don't handle the click again anywhere else...
			get_viewport().set_input_as_handled()
