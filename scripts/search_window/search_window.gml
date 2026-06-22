function search_window(_label, query, content = [], widget = empty_function, _button){
	var width = 350;
	var height = 400;
	
	set_next_window_pos(
		display_get_gui_width() / 2 - width  / 2, 
		display_get_gui_height() / 2 - height / 2, 
	);
	
	set_next_window_size(width, height);
	
	
	var flags = (EImGui_WindowFlags.NoMove | EImGui_WindowFlags.NoResize | EImGui_WindowFlags.NoCollapse);
	start(_label + "### query", undefined, flags);
		begin_group();
			query = textbox(query, "queryInput");
			same_line();
			
			if (_button != undefined) if (button(_button.label)) _button.onClick();
		end_group();
		
		separator();
		
		begin_group();
			for(var i = 0; i < array_length(content); i++) {
				widget(content[i]);
			}
		end_group();
		
		var focus = is_window_focused();
	finish();
	
	
	return [query, focus];
}