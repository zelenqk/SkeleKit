function read_config(){
	ini_open("skelekit_editor.ini");
		var width = ini_read_real("EDITOR_LAYOUT", "width", 1366);
		var height = ini_read_real("EDITOR_LAYOUT", "height", 768);
		var ax = ini_read_real("EDITOR_LAYOUT", "x", 0.5 - (width / 2) / display_get_width());
		var ay = ini_read_real("EDITOR_LAYOUT", "y", 0.5 - (height / 2) / display_get_height());
		
		window_set_size(width, height);
		window_set_position(display_get_width() * ax, display_get_height() * ay);
		display_set_gui_size(width, height);
	ini_close();
}

function write_config(){
	ini_open("skelekit_editor.ini");
		ini_write_real("EDITOR_LAYOUT", "width", window_get_width());
		ini_write_real("EDITOR_LAYOUT", "height", window_get_height());
		ini_write_real("EDITOR_LAYOUT", "x", window_get_x() / display_get_width());
		ini_write_real("EDITOR_LAYOUT", "y", window_get_y() / display_get_height());
	ini_close();
}