function imGuiPrefabs() : gmGui() constructor {
	cache = {};
	
	//-------------------base widgets-------------------
		
	static paragraph = function(_label){
	    var _start = get_cursor_screen_pos(); // absolute screen coords, BEFORE drawing
	    var avail = get_content_region_avail();
		
		begin_group();
			text(_label);

			var ty = _start[1] + (get_cursor_screen_pos()[1] - _start[1]) / 2 - 2;
			var px = get_cursor_screen_pos()[0]
			same_line();
			var tx = get_cursor_screen_pos()[0];
			var width = avail[0] - (tx - px);
			drawlist_add_line(tx, ty, tx + width, ty, $20FFFFFF);
		end_group();
	}
	
	///@function window
	///@param {String} label
	///@param {String} id
	///@param {Function} widget
	///@param {Real} tx
	///@param {Real} ty
	///@param {Real} width
	///@param {Real} height
	///@param {Real} flags
	static window = function(_label, _id, widget = empty_function, tx, ty, width, height, flags = 0, firstTime = false) {
		var condition = (firstTime ? EImGui_Cond.FirstUseEver : 0);
		set_next_window_pos(tx, ty, condition);
		set_next_window_size(width, height, condition);
		
		start(_label + "###" + _id, undefined, flags);
			widget();
		finish();
	}
	
	//-------------------menu widgets-------------------
	static main_menu = function(widget = empty_function){
		if (begin_main_menu_bar()) widget();
		var size = get_window_size();
		end_main_menu_bar();
		
		return size;
	}
	
	static menu_strip = function(_label, _id, widget){
		if (begin_menu(_label + "###" + _id)){
			widget();
			end_menu();
		}
	}
	
	//input widgets
	static textbox = function(_text, _id) {
		var ret = input_text("###" + _id, _text, 100);
		return ret[1];
	}
	
	static int_input = function(_label, _id, num, _step, _stepFast, onChange = empty_function, flags = 0){
		var ret = input_int(_label + "###" + _id, num, _step, _stepFast, onChange);
		if (ret[0]) onChange(ret[1]);
		return ret[1];
	}
	
	static color_editor = function(_label, _id, _color, onChange = empty_function){
	    if (cache[$ _id] == undefined) {
	        var hsv = color_convert_rgb_to_hsv(
	            color_get_red(_color)   / 255,
	            color_get_green(_color) / 255,
	            color_get_blue(_color)  / 255
	        );
			
	        cache[$ _id] = hsv; // [h, s, v]
	    }
		
	    var hsv_state = cache[$ _id];
	    var rgb = color_convert_hsv_to_rgb(hsv_state[0], hsv_state[1], hsv_state[2]);
	    var ret = color_edit3(_label + "###" + _id, rgb);
	
	    var final_rgb = color_convert_hsv_to_rgb(cache[$ _id][0], cache[$ _id][1], cache[$ _id][2]);
	    var col = make_color_rgb(final_rgb[0] * 255, final_rgb[1] * 255, final_rgb[2] * 255);
		
	    if (ret[0]) {
			cache[$ _id] = color_convert_rgb_to_hsv(ret[1], ret[2], ret[3]);
			onChange(col);
		}
		
	
		return col;
	}
}	



function empty_function() {
	return empty_function;
}