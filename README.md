Radial Menu Control
===================

This code provides a radial menu control node for Godot Engine 4 (also called a "pie menu") with support for submenus. It supports keyboard, mouse and gamepad input. You can define the basic look of the control using themes:

<img src="addons/RadialMenu/doc/LightvsDarkTheme.png">

You can also change some menu geometry settings, such as how much of a full ring is covered by the menu, the radius and width of the ring/arc via exported properties:

<img src="addons/RadialMenu/doc/ExportedProperties.png">

A short demo video of the radial menu control is available at https://youtu.be/uATC5JfqUkI.


Setup
-----

There are three alternative ways to set up your radial menu:
   
   1. Activate the RadialMenu *plugin* in your project settings and then add a radial menu to your scene tree using the new RadialMenu node that should become available with plugin activation.

   2. Preload the RadialMenu.gd Script in your script and then create a new RadialMenu
	  via script:

	# Preload the script and call it 'RadialMenu'
	const RadialMenu = preload("path_to/addons/RadialMenu/RadialMenu.gd")
	...
	# create a radial menu
	var menu = RadialMenu.new()    

   3. Instance the provided `RadialMenu.tscn` scene in your own scene tree. The 
	  scene contains a single Control node that has the `RadialMenu.gd` script attached.

Note that adding children to the RadialMenu node currently has no effect, but this may change in later versions, so *do not add children to a radial menu* in your scene tree if you want to make sure later versions will still work.

The radial menu control node inherits from the builtin Popup node and as such has all the behaviour of popups.  This means that you must provide some code to *open* the popup; the radial menu is hidden by default when you run the scene.

There are three Demo scenes under `addons/RadialMenu/Demo/RadialDemo[123].tscn` with working radial menus, including one with submenus.

The radial menu comes preconfigured with 7 dummy entries with star icons which you must reconfigure in order to make it usable. If your menu shows 7 star items, you've forgotten to configure the menu items.

Menu items are configured as a list of dictionaries:

	var items = [
	   {'texture': SOME_TEXTURE, 
		'title': 'A short title', 
		'id': 'anything, really'
	   },
	   ...
	]
	# assuming that menu references your RadialMenu node...
	menu.set_items(items)

The method `set_items` takes such a list and reconfigures the menu items. You can also manipulate the `menu_items`-property directly. 

If the value for an item's action key is a RadialMenu node, it will be treated as a **submenu** and opened when the menu item is activated. See `RadialDemo3.tscn` for an example.

**Note:** Although the title key currently isn't used, it will be displayed by default in a later version, so in order to remain compatible with future versions, *do provide* a *short* title for each menu item.

Signals
-------

A radial menu control node emits three signals:

   1. `item_selected(id, position)`

   2. `item_hovered(menu_item)`

   3. `cancelled()`

   4. `menu_opened(menu)`

   5. `menu_closed(menu)`

The `item_selected` signal is emitted when a menu item is chosen and 
accepted via one of the supported input methods. `position` returns the original position at which the menu was opened via a call to `open_menu`.

The `item_hovered` signal is emitted when a menu item is selected but not yet
accepted as the user's choice; for example when the mouse first hovers over it.

The `cancelled` signal is emitted when the user closes the menu without having made a choice.


Configuration options
---------------------

The main parameters are the menu radius (always measured from the center to the the outermost edge) and the width of the ring which holds the items. The radial menu doesn't have to be a full ring; you can also configure it as an arc. The center of the arc can sit at any angle.

Colors and some size constants such as the width of the decorator ring/arc and the selector segment can be configured via themes. See the provided light and dark themes for an example.

<img src="addons/RadialMenu/doc/config-naming.svg.png" width="450px">


Public Properties
-----------------

All the following properties are considered to belong to the public interface; you can acess and change these properties at will. All of these properties except `menu_items` are also exported by the script and can be changed directly in the Godot editor.

	menu_items

A list of dictionaries containing 'texture', 'title' and 'action' keys (at least). You can
also use the `set_items` method instead.

	radius 

Sets the radius of the menu.

	width

Sets the width of the ring that holds the menu items.

	center_radius

Sets the radius of the center ring. If you set it to 0, the center won't be drawn.

	circle_coverage : float

Determines how much of a full circle the menu covers. Must be a value between 0 and 1, though values below a certain treshold (the exact number varies depending on radius, width etc) don't make sense.

	center_angle : float

Sets the angle where the center of the radial arc is located. Values are in radians. The default is -PI/2, e.g. the arc is centered at 12 o'Clock.

	selector_position 

Sets the position of the selector. It's either `Position.off`, `Position.inside` (default), or `Position.outside`.

	decorator_position

Sets the position of the decorator ring. It's either `Position.off`, `Position.inside` (default), or `Position.outside`.

	show_animation : bool

A boolean which controls whether animations are enabled (default) or disabled. 

	animation_speed_factor: float

This changes the speed of the animation. Smaller values get you a faster animation. Ignored if `show_animation` is false.

	outside_selection_factor : float

A float which determines how far beyond the ring the mouse can still select a menu item. The factor is in ring widths, so a value of 0 means the mouse won't select outside of the ring at all, and 1 means the mouse will select up to a full ring width beyond the outer edge of the ring. Defaults to 3.

	icon_scale : float

Factor by which icons are scaled. This is applied to all textures provided via `menu_items`. Defaults to 1.

	default_theme : Theme

Provides default values for colors and some constants which are used unless another active theme has entries for RadialMenu, which will override those of the default theme. Two example themes are provided; the dark one is the standard. Don't clear the default theme! You don't need to bother with the default theme property if you're providing your own theme - you can just use the `theme` property instead.


Public Methods
--------------

	set_items(items)

Sets all menu items at once. You can also set the `menu_items` property directly.

	open_menu(center_position: Vector2)

Opens the RadialMenu (e.g. makes it visible at the given position). Do not place the menu yourself and call `show()`; use this method instead.

	add_icon_item(texture : Texture, title: String, id)

Adds an item represented by an icon to the menu. Note: Calling add_icon_item is
less efficient than setting all items at once via set_items.

	set_item_text(idx: int, title: String)

Sets the text of a single menu item. The item must exist already.

	set_item_id(idx: int, id)

Sets the action of a single menu item. The item must exist already.

	set_item_icon(idx: int, texture: Texture)

Sets the icon of a single menu item. The item must exist already.

	select_next()

Selects the next item in clockwise order.

	select_prev()

Selects the previous item in clockwise order (e.g. the next counterclockwise).

	has_open_submenu()

Returns true if a submenu is active, false if not.

	get_open_submenu()

Returns the submenu object if one is currently active, or null.

	setup_gamepad(deviceid : int, xaxis: int, yaxis: int, deadzone: float)



Sets the gamepad device id, x-axis and y-axis that controls the radial menu. 
Deadzone defaults to 0.2 (e.g. 20% of the maximum).


Input handling details
----------------------

The menu navigation reacts to some of the default actions Godot provides:
  
  `ui_cancel` closes a submenu or the main menu without choosing an item.
  `ui_accept` accepts the currently selected choice.
  `ui_focus_next` and `ui_focus_prev` select items clockwise and counterclockwise. `ui_down` and `ui_right` also select clockwise, `ui_up` und `ui_right` counterclockwise.

This takes care of both the keyboard and some of the gamepad navigation.

The mouse wheel also works to select items clockwise and counterclockwise. Moving the mouse back to the center deselects any selection made in the currently active menu; moving it far beyond the menu ring/arc also deselects. You can configure the radius at which deselection happens _outside_ the menu.

To configure gamepad input, you need to call the `setup_gamepad` method on every menu; the default settings let the first gamepad's two lowest-numbered axes control the item selection.

If you want to extend the RadialMenu class, you can override `_input` and call `_radial_input(event)` to get the default radial menu input handling when needed. 


UI considerations
-----------------

Don't pack more than a handful of items into a radial menu, especially when you don't cover the whole ring and when users use gamepads to select items, since it gets harder to select items as the selection angle narrows, and most people's brains have to actually work at processing more than, say, 5-7 items.

Also, currently stacking multiple radial submenus doesn't quite work (though it might in a later version, the code *almost* allows it); but this seems like a bad idea from a UI design standpoint. 

Finally, if you enable the menu animation, you should provide the user with a way to turn the animation off, because it _does_ slow down some people.


Plugin file structure
---------------------

The plugin does not have any third-party dependencies. This section is provided for those who want to trim the code down to the absolute minimum number of files required. 

   1. You *must* include the LICENSE file.

   2. The main work is done by the script `addons/RadialMenu/RadialMenu.gd`. It has several internal dependencies:  `drawing_library.gd` and `dark_default_theme.tres` are required. You need to copy at least these three files into your own projects to get a working RadialMenu control. Also copy the `addons/RadialMenu/icons` folder or create your own. The icons inside it are referenced in the code and there is currently no way to reconfigure these except by changing the relevant constants at the top of `RadialMenu.gd`, but simply replacing the icons will work.

   3. `addons/RadialMenu/RadialMenu.tscn` is optional; it is only needed if you want to create RadialMenus by _instancing_ this scene.

   4. `addons/RadialMenu/radial_menu_plugin.gd` and `addons/RadialMenu/plugin.cfg` are there for plugin initialisation if you want to use the RadialMenu control via the Godot plugin system. Otherwise they are optional.

 All other files, including those under `addons/RadialMenu/Demo`, are optional. 


Known Bugs and Caveats
-----------------------

This is version 1.1. There are bound to be bugs. Please report bugs you encounter so they can be fixed.

The RadialMenu started life as a Popup in Godot 3, but is now a Control node, as Popup has been moved to another branch of the class tree
in Godot 4, which is missing relevant functionality. So now there are positioning issues when you make the RadialMenu a child of a 
Control container. A workaround is to create a Node of class "Node" in the scene tree and make the RadialMenu a child of the node.

License
-------

See the LICENSE file. The code is licensed to you under the MIT license.
