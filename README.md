Radial Menu Control
===================

This code provides a radial menu control node for the Godot Engine. The control
is configurable to adapt to your needs. It supports keyboard, mouse, touch and gamepad 
input, though gamepad input defaults to the first gamepad and the first two axes.


Setup
-----

The radial menu control node inherits from the builtin Popup node and as such has
all the behaviour of popups.  This means that you must provide some code to *open* the popup; the radial menu is hidden by default. 

There is a Demo scene under addons/RadialMenu/Demo/RadialDemo.tscn that shows you how to configure a main menu and a couple of submenues.

The radial menu comes preconfigured with 7 dummy entries with star icons which you must reconfigure in order to make it usable. If your menu shows 7 star items, you've forgotten to configure the menu items.

Menu items are configured as a list of dictionaries:

    items = [
       {'texture': SOME_TEXTURE, 'title': 'A short title', 'action': 'anything, really'},
       ...
    ]

The method `set_items` takes such a list and reconfigures the menu items. You can also
manipulate the `menu_items`-property directly.

If the value for an item's action key is a RadialMenu node, it will be treated as a **submenu** and opened when the menu item is activated.

Signals
-------

A radial menu control node emits three kinds of signals:

   1. `item_selected(action, position)`

   2. `item_hovered(menu_item)`

   3. `cancelled()`

The `item_selected` signal is emitted when a menu item is chosen and 
accepted via one of the supported input methods. 

The `item_hovered` signal is emitted when a menu item is selected but not yet
accepted as the user's choice; for example when the mouse first hovers over it.

The `cancelled` signal is emitted when the user closes the menu without having
made a choice.

No special signal is emitted when a submenu is openend. If you are interested 
interested in that event, you can use the `about_to_show` signal provided by 
the popup.

Configuration options
---------------------

The main parameters of a radial menu are its radius (always measured from the center to the the outermost edge) and the width of the ring that holds the items. The radial menu doesn't have to be a full ring; you can also configure it as an arc. The center of the arc can be configured to sit at any angle.

Colors and some size constants such as the width of the decorator ring/arc and the selector segment can be configured via themes. See the provided dark theme for an example.

<img src="doc/config-naming.svg.png" width="450px">


Public Properties
-----------------

    radius 

Sets the radius of the menu.

    width

Sets the width of the ring that holds the menu items.

...


Public Methods
--------------

    set_items(items)

Sets all menu items at once. You can also set the `menu_items` property directly.


    set_item_text(idx: int, text: String)

Sets the text of a single menu item. The item must exist already.

    set_item_action(idx: int, action)

Sets the action of a single menu item. The item must exist already.

    set_item_icon(idx: int, texture: Texture)

Sets the icon of a single menu item. The item must exist already.


UI considerations
-----------------

Don't pack more than a handful of items into a radial menu, especially when you don't cover the whole ring. Also, while it's possible, it's probably a bad idea to stack multiple radial submenus. Finally, if you enable
the menu animation, you might want to provide the user with a way to turn the animation off, becaus it _does_
slow down some users.


Input handling details
----------------------

Keyboard input is handled via the default actions Godot provides:
  
  `ui_cancel` closes a submenu without choosing an item.
  `ui_accept` accepts the currently selected choice.
  `ui_focus_next` and `ui_focus_prev` select items clockwise and counterclockwise. `ui_down` and `ui_right` also select clockwise, `ui_up` und `ui_right` counterclockwise.

The mouse wheel also works to select items clockwise and counterclockwise. Moving the mouse back to the center deselects any selection made in the currently active menu; moving it far beyond the menu ring/arc also deselects. You can configure the radius at which deselection happens _outside_ the menu.

If you want to extend the class, you can call override `_input` and call `_radial_input(event)` to get the default radial menu input handling when needed.


