@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("RadialMenu", "Popup", preload("RadialMenu.gd"), preload("icons/radial_menu.svg"))
	
func _exit_tree():
	remove_custom_type("RadialMenu")
	
