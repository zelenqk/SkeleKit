function imGuiPrefabs() : gmGui() constructor {
	cache = {};
	
	static main_menu = function(widget = empty_function){
		if (begin_main_menu_bar()) widget();
		end_main_menu_bar();
	}
	
	static menu_strip = function(_label, _id, widget){
		if (begin_menu(_label + "###" + _id)){
			widget();
			end_menu();
		}
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