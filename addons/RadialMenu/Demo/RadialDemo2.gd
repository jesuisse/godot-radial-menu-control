extends Node

const TWODEE_TEXTURE = preload("icons/2D.svg")
const POINTS_TEXTURE = preload("icons/PointMesh.svg")
const GRID_TEXTURE = preload("icons/Grid.svg")
const ORIGIN_TEXTURE = preload("icons/CoordinateOrigin.svg")
const SCALE_TEXTURE = preload("icons/Zoom.svg")
const TOOL_TEXTURE = preload("icons/Tools.svg")


# Called when the node enters the scene tree for the first time.
func _ready():
	# This is inefficient - it would be better to set the all the items 
	# at once using set_items...
	$RadialMenu.set_items([])
	$RadialMenu.add_icon_item(TWODEE_TEXTURE, "2D", 1)
	$RadialMenu.add_icon_item(POINTS_TEXTURE, "Points", 2)
	$RadialMenu.add_icon_item(GRID_TEXTURE, "Grid", 3)
	$RadialMenu.add_icon_item(SCALE_TEXTURE, "Scale", 4)
			

func _input(event):
		
	if event is InputEventMouseButton:		
		# open the menu
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			var m = event.position
			# Pass the center position to open_menu as a Vector2!
			$RadialMenu.open_menu(m)
			# Make sure we don't handle the click again anywhere else...
			get_viewport().set_input_as_handled()
