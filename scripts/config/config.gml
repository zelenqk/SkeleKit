function read_config(){
	ini_open("skelekit_editor.ini");
		//window config
		var width = ini_read_real("EDITOR_LAYOUT", "width", 1366);
		var height = ini_read_real("EDITOR_LAYOUT", "height", 768);
		var ax = ini_read_real("EDITOR_LAYOUT", "x", 0.5 - (width / 2) / display_get_width());
		var ay = ini_read_real("EDITOR_LAYOUT", "y", 0.5 - (height / 2) / display_get_height());
		window_set_size(width, height);
		window_set_position(display_get_width() * ax, display_get_height() * ay);		
		
		//grid config
		grid.size = ini_read_real("EDITOR", "grid size", 32);
		grid.line = ini_read_real("EDITOR", "grid line_color", grid.line);
		grid.origin = ini_read_real("EDITOR", "grid origin_color", grid.origin);
		grid.build();

		display_set_gui_size(width, height);
	ini_close();
}

function write_config(){
	ini_open("skelekit_editor.ini");
		ini_write_real("EDITOR_LAYOUT", "width", window_get_width());
		ini_write_real("EDITOR_LAYOUT", "height", window_get_height());
		ini_write_real("EDITOR_LAYOUT", "x", window_get_x() / display_get_width());
		ini_write_real("EDITOR_LAYOUT", "y", window_get_y() / display_get_height());
		
		ini_write_real("EDITOR", "grid size", grid.size);
		ini_write_real("EDITOR", "grid line_color", grid.line);
		ini_write_real("EDITOR", "grid origin_color", grid.origin);
	ini_close();
}