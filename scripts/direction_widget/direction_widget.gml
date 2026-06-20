/// direction_widget(state, label_id)
/// Draws a circular dial with a line pointing at state.angle (radians).
/// Click+drag anywhere on the circle to set the direction.
///
/// state struct fields:
///   angle    - current direction in radians (0 = right, increases clockwise in screen space)
///   radius   - px radius of the dial
function direction_widget(angle, r, label_id) {
	var col_bg        = 0xFF302820;
	var col_ring       = 0xFF7A6A56;
	var col_needle     = 0xFF6060FF;
	var col_center_dot = 0xFFE0E0E0;

	var size = r * 2;

	// reserve layout space + screen-space origin for drawing
	var origin = imguigml_get_cursor_screen_pos();
	var ox = origin[0] + r;
	var oy = origin[1] + r;

	// invisible hitbox covering the dial's bounding box
	imguigml_invisible_button(label_id, size, size);
	var active  = imguigml_is_item_active();   // true while being dragged (mouse held since click on this item)
	var hovered = imguigml_is_item_hovered();

	// --- input: update angle while dragging ---
	if (active and imguigml_is_mouse_down(0)) {
		var mx = display_mouse_get_x(); // swap for imguigml mouse-pos getter if you have one
		var my = display_mouse_get_y();
		angle = arctan2(my - oy, mx - ox);
	}

	// --- draw ---
	imguigml_drawlist_add_circle_filled(ox, oy, r, col_bg);
	imguigml_drawlist_add_circle(ox, oy, r, col_ring, 0, 2.0); // 0 segments = auto smooth, adjust if your signature differs

	var nx = ox + lengthdir_x(r * 0.85, -radtodeg(angle)); // GM's lengthdir uses degrees, screen-y flipped
	var ny = oy + lengthdir_y(r * 0.85, -radtodeg(angle));
	imguigml_drawlist_add_line(ox, oy, nx, ny, col_needle, 3.0);

	imguigml_drawlist_add_circle_filled(ox, oy, 4, col_center_dot);

	return -radtodeg(angle);
}