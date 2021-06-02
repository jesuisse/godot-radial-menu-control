extends PanelContainer

"""
(c) 2021 Pascal Schuppli

This code is made available under the MIT license. See LICENSE for further
information.
"""

const TWODEE_TEXTURE = preload("../icons/2D.svg")
const POINTS_TEXTURE = preload("../icons/PointMesh.svg")
const GRID_TEXTURE = preload("../icons/Grid.svg")
const ORIGIN_TEXTURE = preload("../icons/CoordinateOrigin.svg")
const SCALE_TEXTURE = preload("../icons/ToolScale.svg")
const TOOL_TEXTURE = preload("../icons/Tools.svg")

const RadialMenu = preload("../RadialMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Create a submenu
	var submenu1 = RadialMenu.instance()
	submenu1.circle_coverage = 0.45
	submenu1.width = $RadialMenu.width
	submenu1.default_theme = $RadialMenu.default_theme
	
	# ... and a second one
	var submenu2 = RadialMenu.instance()
	submenu2.circle_coverage = 0.45
	submenu2.width = $RadialMenu.width
	submenu2.default_theme = $RadialMenu.default_theme
		
	# ... and a third one	
	var submenu3 = RadialMenu.instance()
	submenu3.circle_coverage = 0.45
	submenu3.width = $RadialMenu.width
	submenu3.default_theme = $RadialMenu.default_theme		
	
	# ... and a fourth one	
	var submenu4 = RadialMenu.instance()
	submenu4.circle_coverage = 0.45
	submenu4.width = $RadialMenu.width
	submenu4.default_theme = $RadialMenu.default_theme	
		
	# Define the main menu's items
	$RadialMenu.menu_items = [
		{'texture': TWODEE_TEXTURE, 'title': "Axis\nSetup", 'action': submenu1}, 
		{'texture': POINTS_TEXTURE, 'title': "Dataset\nSetup", 'action': submenu2},
		{'texture': GRID_TEXTURE, 'title': "Grid\nSetup", 'action': submenu3},
		{'texture': TOOL_TEXTURE, 'title': "Advanced\nTools", 'action': submenu4},
		{'texture': ORIGIN_TEXTURE, 'title': "Back to\norigin", 'action': "action5"},
		{'texture': SCALE_TEXTURE, 'title': "Reset\nscale", 'action': "action6"},		
	]
		
	
func _input(event):
	if event is InputEventMouseButton:		
		
		if event.is_pressed() and event.button_index == BUTTON_RIGHT:
			var m = get_local_mouse_position()			
			$RadialMenu.open_menu(m)
			get_tree().set_input_as_handled()


func _on_ArcPopupMenu_item_selected(action, _position):
	if action is Node:
		$MenuResult.text = "Submenu activated"
	else:
		$MenuResult.text = action

