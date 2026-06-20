globalvar __imguigml;
__imguigml = noone;

function UI() constructor {
	self.context = new imgui_context();
	
	step = context.step;
	render = context.render;
	destroy = context.destroy;
	
	/// @func timeline_widget()
	/// timeline_widget(struct)
	/// Call this every step inside your ImGui window, between imguigml_begin()/imguigml_end()
	///
	/// state struct fields you must keep around per-instance:
	///   current_frame   - the cursor's frame index (read/write — drag updates this)
	///   frame_count     - total number of frames in the timeline
	///   frame_width     - px width of each frame tick (zoom level)
	///   height          - px height of the timeline strip
	///   scroll_x        - horizontal scroll offset in px (you manage/persist this)
	///   dragging        - bool, true while the user is scrubbing
	static timeline_widget = function(state) {
		var col_bg        = 0xFF302820; // ABGR-ish order depends on your wrapper's Uint32 packing, adjust if colors look wrong
		var col_tick      = 0xFF564A3C;
		var col_tick_major= 0xFF7A6A56;
		var col_cursor    = 0xFF4040F0;
		var col_cursor_head = 0xFF6060FF;
	
		var width  = 600;
		var height = 128;
	
		// origin in screen space (so draw list calls line up with real pixels)
		var origin = imguigml_get_cursor_screen_pos();
		var ox = origin[0];
		var oy = origin[1];
	
		// --- clip / scroll region ---
		// begin_child gives us the hidden-overflow scrollable strip
		var tx = display_get_gui_width() / 2 - width / 2;
		var ty = display_get_gui_height() - height;
		
		imguigml_set_next_window_size(width, height);
		
		var flags = EImGui_WindowFlags.NoResize | EImGui_WindowFlags.NoCollapse;
		
		imguigml_begin("timeline", undefined, flags)
		

		imguigml_end();
	}
	
	/// @func ready()
	/// @desc Called to check if the UI class is ready
	/// @returns Bool
	static ready = function() {
		return imguigml_ready();
	}

	static paragraph = function(text = ""){
		imguigml_text(text);
		
		var start = imguigml_get_cursor_screen_pos();
		imguigml_same_line();
		var screen_pos = imguigml_get_cursor_screen_pos();
		imguigml_new_line();
		
		var delta = (start[1] - screen_pos[1]) / 2
 		
		var sx = screen_pos[0];
		var sy = screen_pos[1] + delta;
		
		imguigml_drawlist_add_line(sx, sy, sx + 300, sy, $1fffffff);
	}
		
	static image_button_with_text = function(_id, _sprite, _sprite_index, _top_text, _bottom_text, _height = 32, _img_size = 64) {
	    var avail = imguigml_get_content_region_avail();
	    var width = avail[0];
	
	    var start_screen_pos = imguigml_get_cursor_screen_pos();
	
	    // 1. invisible button claims the click + reserves the layout space
	    var clicked = imguigml_invisible_button(_id, width, _height);
	    var hovered = imguigml_is_item_hovered();
	
	    // 2. jump cursor back to the top-left of that same region to draw real content on top
	    imguigml_set_cursor_screen_pos(start_screen_pos[0], start_screen_pos[1]);
	
	    var sx = start_screen_pos[0];
	    var sy = start_screen_pos[1];
	
	    // 3. draw the BUTTON background, spanning the full button area
	    var btn_color = hovered
	        ? imguigml_get_color_u32(0.3, 0.3, 0.3, 1.0)
	        : imguigml_get_color_u32(0.15, 0.15, 0.15, 1.0);
	
	    imguigml_drawlist_add_quad_filled(
	        sx,           sy,
	        sx + width,   sy,
	        sx + width,   sy + _height,
	        sx,           sy + _height,
	        btn_color
	    );
	
	    // 4. draw image on top of the button background
	    imguigml_sprite(_sprite, _sprite_index, _img_size, _img_size);
	    imguigml_same_line();
	
	    // 5. draw the two stacked text lines to the right of the image, vertically grouped
		// top text: larger, lighter
		imguigml_set_window_font_scale(2); // 1.5x the base font size — half-again as your "half the height" target, tweak the multiplier to taste
		imguigml_push_style_color(EImGui_Col.Text, 0.9, 0.9, 0.9, 1.0); // light gray/near-white
		imguigml_begin_group();
		    imguigml_text(_top_text);
		
		imguigml_pop_style_color(1);
		imguigml_set_window_font_scale(1); // reset before drawing the next thing


		// bottom text: smaller, darker
		imguigml_push_style_color(EImGui_Col.Text, 0.65, 0.65, 0.65, 0.70); // darker gray
		imguigml_text(_bottom_text);
		imguigml_pop_style_color(1);
		imguigml_end_group();

		return clicked;
	}
	
	#region BUTTONS
		/// @func button(_label, _on_click, [_size_x = 0], [_size_y = 0])
		/// @param {String} _label This is the label for the button
		/// @param {String} _id The id of the button. Needs to be unique
		/// @param {Function} _on_click Gets call if clicked
		/// @param {Real} _size_x Width of button. Use 0 for automatic sizing
		/// @param {Real} _size_y Height of button. Use 0 for automatic sizing
		static button = function(_label, _id, _on_click, _size_x = 0, _size_y = 0) {
			if(imguigml_button(string(_label) + "###" + string(_id), _size_x, _size_y) == true) {
				_on_click();
			}
		}

		/// @func button_small(_label, _on_click)
		/// @param {String} _label This is the label for the button
		/// @param {String} _id The id of the button. Needs to be unique
		/// @param {Function} _on_click Gets call if clicked
		static button_small = function(_label, _id, _on_click) {
			if(imguigml_small_button(string(_label) + "###" + string(_id)) == true) {
				_on_click();
			}
		}
	#endregion

	#region SLIDERS
		/// @func slider_int(_label, _values, _min, _max, _on_change, [_format = "%.0f"])
		/// @param {String} _label This is the label to show
		/// @param {String} _id The id of the button. Needs to be unique
		/// @param {Array} _values Array of values to assign to each slider
		/// @param {Real} _min The minimum amount allowed when sliding
		/// @param {Real} _max The maximum amount allow when sliding
		/// @param {Function} _on_change The call back function to call when the value has changed
		/// @param {String} _format The format of the string to display
		static slider_int = function(_label, _id, _values, _min, _max, _on_change, _format = "%.0f") {
		var slider_length = array_length(_values);
		var ret = [0, 0];
		
		switch(slider_length) {
			case 1:
				ret = imguigml_slider_int(string(_label) + "###" + string(_id), _values[0], _min, _max, _format);
			break;
			case 2:
				ret = imguigml_slider_int2(string(_label) + "###" + string(_id), _values[0], _values[1], _min, _max, _format);
			break;
			case 3:
				ret = imguigml_slider_int3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _min, _max, _format);
			break;
			default: // 4
				ret = imguigml_slider_int4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[3], _values[4], _min, _max, _format);
			break;
		}
		
		if(ret[0] == 1) {
			switch(slider_length) {
				case 1:
					_on_change(ret[1]);
				break;
				case 2:
					_on_change(ret[1], ret[2]);
				break;
				case 3:
					_on_change(ret[1], ret[2], ret[3]);
				break;
				default: // 4
					_on_change(ret[1], ret[2], ret[3], ret[4]);
				break;
			}
		}
	}
	
	/// @func slider_float(_label, _values, _min, _max, _on_change, [_format = "%.3f]")
	/// @param {String} _label This is the label to show
	/// @param {String} _id The id of the button. Needs to be unique
	/// @param {Array} _values Array of values to assign to each slider
	/// @param {Real} _min The minimum amount allowed when sliding
	/// @param {Real} _max The maximum amount allow when sliding
	/// @param {Function} _on_change The call back function to call when the value has changed
	/// @param {String} _format The format of the string to display
	static slider_float = function(_label, _id, _values, _min, _max, _on_change, _format = "%.3f", _flags = EImGui_SliderFlags.None) {
		var slider_length = array_length(_values);
		var ret = [0, 0];
		
		switch(slider_length) {
			case 1:
				ret = imguigml_slider_float(string(_label) + "###" + string(_id), _values[0], _min, _max, _format, _flags);
			break;
			case 2:
				ret = imguigml_slider_float2(string(_label) + "###" + string(_id), _values[0], _values[1], _min, _max, _format, _flags);
			break;
			case 3:
				ret = imguigml_slider_float3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _min, _max, _format, _flags);
			break;
			default: // 4
				ret = imguigml_slider_float4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[3], _values[4], _min, _max, _format, _flags);
			break;
		}
		
		if(ret[0] == 1) {
			switch(slider_length) {
				case 1:
					_on_change(ret[1]);
				break;
				case 2:
					_on_change(ret[1], ret[2]);
				break;
				case 3:
					_on_change(ret[1], ret[2], ret[3]);
				break;
				default: // 4
					_on_change(ret[1], ret[2], ret[3], ret[4]);
				break;
				}
			}
		}
	#endregion

	#region MENUS
		/// @func menu_main(_callback)
		/// @desc This will create a main menu bar at the top of applications
		/// @param {Function} _callback This is the callback function. Inside you will place other menu items
		static menu_main = function(_callback) {
			if(imguigml_begin_main_menu_bar()) {
				_callback();
			}
			
			imguigml_end_main_menu_bar();
		}

		/// @func menu_strip(_label, _id, _on_click)
		/// @desc Menu Strip will go on current window. Please have EImGui_WindowFlags.MenuBar on the window
		/// @param {String} _label This if the menu text
		/// @param {String} _id The id of the button. Needs to be unique
		/// @param {Function} _on_click This is what you want to happen when they click it
		static menu_strip = function(_label, _id, _on_click) {
			if(imguigml_begin_menu(string(_label) + "###" + string(_id))) {
				_on_click();

				imguigml_end_menu();
			}
		}

		/// @func menu_item(_label, _id, _on_click)
		/// @param {String} _label This if the menu text
		/// @param {String} _id The id of the button. Needs to be unique
		/// @param {Function} _on_click This is what you want to happen when they click it
		/// @param {String} _shortcut Short cut key
		static menu_item = function(_label, _id, _on_click, _shortcut = "") {
			if (imguigml_menu_item(string(_label) + "###" + string(_id), _shortcut)) {
				_on_click();
			}
		}
	#endregion

	#region DRAGS (SAME AS A SLIDER WITHOUT HANDLE)
		/// @func drag_int(_label, _id, _values, _min, _max, _on_change, [_step = 0.5], [_format = "%.0f"], [_flags = EImGui_SliderFlags.None])
		/// @param {String} _label This if the menu text
		/// @param {String} _id The id of the drag. Needs to be unique
		/// @param {Array} _values The default values to assign
		/// @param {Real} _min Minimum value that can be achieved by dragging
		/// @param {Real} _max Maximum value that can be achieved by dragging
		/// @param {Function} _on_change The callback function when something changed
		/// @param {Real} _step how much to increment in
		/// @param {Real} _format the decimal format
		/// @param {Real} _flags The flags to pass through
		static drag_int = function(_label, _id, _values, _min, _max, _on_change, _step = 0.5, _format = "%.0f", _flags = EImGui_SliderFlags.None) {
			var ret = [0,0];
			var drag_length = array_length(_values);
		
			switch(drag_length) {
				case 1:
					ret = imguigml_drag_int(string(_label) + "###" + string(_id), _values[0], _step, _min, _max, _format);
				break;
				case 2:
					ret = imguigml_drag_int2(string(_label) + "###" + string(_id), _values[0], _values[1], _step, _min, _max, _format);
				break;
				case 3:
					ret = imguigml_drag_int3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _step, _min, _max, _format);
				break;
				default: // 4
					ret = imguigml_drag_int4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[3], _values[4], _step, _min, _max, _format);
				break;
			}
		
			if(ret[0] == 1) {
				switch(drag_length) {
					case 1:
						_on_change(ret[1]);
					break;
					case 2:
						_on_change(ret[1], ret[2]);
					break;
					case 3:
						_on_change(ret[1], ret[2], ret[3]);
					break;
					default: // 4
						_on_change(ret[1], ret[2], ret[3], ret[4]);
					break;
				}
			}
		}

		/// @func drag_float(_label, _id, _values, _min, _max, _on_change, [_step = 0.5], [_format = "%.3f"], [_flags = EImGui_SliderFlags.None])
		/// @param {String} _label This if the menu text
		/// @param {String} _id The id of the drag. Needs to be unique
		/// @param {Array} _values The default values to assign
		/// @param {Real} _min Minimum value that can be achieved by dragging
		/// @param {Real} _max Maximum value that can be achieved by dragging
		/// @param {Function} _on_change The callback function when something changed
		/// @param {Real} _step how much to increment in
		/// @param {Real} _format the decimal format
		/// @param {Real} _flags The flags to pass through
		static drag_float = function(_label, _id, _values, _min, _max, _on_change, _step = 0.5, _format = "%.3f", _flags = EImGui_SliderFlags.None) {
			var ret = [0,0];
			var drag_length = array_length(_values);

			switch(drag_length) {
				case 1:
					ret = imguigml_drag_float(string(_label) + "###" + string(_id), _values[0], _step, _min, _max, _format, _flags);
				break;
				case 2:
					ret = imguigml_drag_float2(string(_label) + "###" + string(_id), _values[0], _values[1], _step, _min, _max, _format, _flags);
				break;
				case 3:
					ret = imguigml_drag_float3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _step, _min, _max, _format, _flags);
				break;
				default: // 4
					ret = imguigml_drag_float4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[3], _values[4], _step, _min, _max, _format, _flags);
				break;
			}

			if(ret[0] == 1) {
				switch(drag_length) {
					case 1:
						_on_change(ret[1]);
					break;
					case 2:
						_on_change(ret[1], ret[2]);
					break;
					case 3:
						_on_change(ret[1], ret[2], ret[3]);
					break;
					default: // 4
						_on_change(ret[1], ret[2], ret[3], ret[4]);
					break;
				}
			}
		}
	#endregion
		
	#region PUSH ITEM WIDTH
		/// @func push_item_width(width)
		/// @parameter width {int} width
		static push_item_width = function(width){
			imguigml_push_item_width(width);	
		}
	
	#endregion
		
	#region INPUTS (WITH BUTTONS)
		/// @func input_int(_label, _values, _step, _step_fast, _on_change, _flags)
		/// @parameter _label {String} Label
		/// @parameter _id {String} This is the ID (needs to be unique)
		/// @parameter _values {Array} Array of values
		/// @parameter _step {Real} How fast when clicked
		/// @parameter _step_fast {Real} How fast when held down
		/// @parameter _on_change {Function} Function to call on change
		/// @parameter _flags {Real} Flags
		static input_int = function(_label, _id, _values, _step, _step_fast, _on_change, _flags = 0) {
			var ret = [0,0];
			var int_length = array_length(_values);
		
			switch(int_length) {
				case 1:
					ret = imguigml_input_int(string(_label) + "###" + string(_id), _values[0], _step, _step_fast, _flags);
				break;
				case 2:
					ret = imguigml_input_int2(string(_label) + "###" + string(_id), _values[0], _values[1], _step, _step_fast, _flags);
				break;
				case 3:
					ret = imguigml_input_int3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _step, _step_fast, _flags);
				break;
				default:
					ret = imguigml_input_int4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _values[3], _step, _step_fast, _flags);
				break;
			}
		
			if(ret[0] == 1) {
				switch(int_length) {
					case 1:
						_on_change(ret[1]);
					break;
					case 2:
						_on_change(ret[1], ret[2]);
					break;
					case 3:
						_on_change(ret[1], ret[2], ret[3]);
					break;
					default: // 4
						_on_change(ret[1], ret[2], ret[3], ret[4]);
					break;
				}
			}
		}
		
		/// @func input_float(_label, _id, _values, _step, _step_fast, _on_change, [_decimal_precision = 1], [_flags = 0])
		/// @param {String} _label The label to write beside. 
		/// @param {String} _id The id to help. Needs to be unique
		/// @param {Array} _values The values to change
		/// @param {Real} _step When you click the + button. Only applies to single
		/// @param {Real} _step_fast When you hold the + button. Only applies to single
		/// @param {Function} _on_change The callback function
		/// @param {Real} _decimal_precision The decimal precision. Default 0.1
		/// @param {Real} _flags Flags to pass from EImGui_InputTextFlags
		static input_float = function(_label, _id, _values, _step, _step_fast, _on_change, _decimal_precision = 1, _flags = 0) {
			var ret = [0,0];
			var int_length = array_length(_values);
		
			switch(int_length) {
				case 1:
					ret = imguigml_input_float(string(_label) + "###" + string(_id), _values[0], _step, _step_fast, _decimal_precision, _flags);
				break;
				case 2:
					ret = imguigml_input_float2(string(_label) + "###" + string(_id), _values[0], _values[1], _decimal_precision, _flags);
				break;
				case 3:
					ret = imguigml_input_float3(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _decimal_precision, _flags);
				break;
				default:
					ret = imguigml_input_float4(string(_label) + "###" + string(_id), _values[0], _values[1], _values[2], _values[3], _decimal_precision, _flags);
				break;
			}
		
			if(ret[0] == 1) {
				switch(int_length) {
					case 1:
						_on_change(ret[1]);
					break;
					case 2:
						_on_change(ret[1], ret[2]);
					break;
					case 3:
						_on_change(ret[1], ret[2], ret[3]);
					break;
					default: // 4
						_on_change(ret[1], ret[2], ret[3], ret[4]);
					break;
				}
			}
		}
	#endregion

	#region CHECKBOX
		/// @func checkbox(_label, _id, _value, _on_change)
		/// @param {String} _label Title name of the window
		/// @param {String} _id This is the ID. Needs to be unique
		/// @param {String} _value default value
		/// @param {Function} _on_change callback function
		static checkbox = function(_label, _id, _value, _on_change) {
			var ret = imguigml_checkbox(string(_label) + "###" + string(_id), _value);

			if(ret[0] == 1) {
				_on_change(ret[1]);
			}
		}
	#endregion
	
	#region SELECT
		/// @func select(_label, _current, _items, _on_change)
		/// @param {String} _label Title of select
		/// @param {Real} _current The current index (from an array) of what the select is
		/// @param {Array} _items An array of items that the user can select
		/// @param {Function} _on_change the callback function that will return the index selected
		static select = function(_label, _current, _items, _on_change) {
			var ret = imguigml_combo(_label, _current, _items);
			
			if(ret[0] == 1) {
				_on_change(ret[1]);
			}
		}
	#endregion

	#region HELPERS
	
		/// @func gui_width()
		/// @desc returns the gui width
		/// @return Real
		static gui_width = function() {
			return display_get_gui_width();
		}
		
		/// @func gui_height()
		/// @desc returns the gui height
		/// @return Real
		static gui_height = function() {
			return display_get_gui_height();
		}
	
		/// @func is_item_hover()
		/// @desc will return true/false if an imgui control is being hovered
		/// @return Bool
		static is_item_hovered = function() {
			return imguigml_is_any_item_hovered();
		}

		/// @func separator()
		/// @desc Will generate a horizontal separate if used in a menu. This becomes vertical otherwise
		static separator = function() {
			imguigml_separator();
		}

		/// @func same_line([_width = 0])
		/// @desc Will cause the next control to be on the same line
		/// @param {Real} _width how much space between
		static same_line = function(_width = 0) {
			imguigml_same_line(_width);
		}

		/// @func new_line()
		/// @desc Will force a new line between controls
		static new_line = function() {
			imguigml_new_line();
		}

		/// @func set_input_width([_width = 0])
		/// @param {Real} _width 0 = default to ~2/3 of windows width >0.0f: width in pixels <0.0f align xx pixels to the right of window (so -1.0f always align width to the right side)
		static set_input_width = function(_width = 0) {
			imguigml_push_item_width(_width);
		}

		///@func indent([_amount = 0])
		///@param {Real} _amount The amount to unindent. If above 0 then use pixel for indent otherwise default amount
		static indent = function(_amount = 0) {
			imguigml_indent(_amount);
		}
	
		///@func unindent([_amount = 0])
		///@param {Real} _amount The amount to indent. If above 0 then use pixel for indent otherwise default amount
		static unindent = function(_amount = 0) {
			imguigml_unindent(_amount);
		}

		/// @func tooltip(_string)
		/// @desc Call after a control to apply a tooltip when mousing over
		/// @param {String} _string  the text to use
		static tooltip = function(_string) {
			var tex = sprite_get_texture(sTooltip, 0);
			var uv = sprite_get_uvs(sTooltip, 0);
			
			imguigml_image(tex, 16, 16, uv[0], uv[1], uv[2], uv[3]);
			if (imguigml_is_item_hovered()) {
			    imguigml_begin_tooltip();
			    imguigml_text(_string);
			    imguigml_end_tooltip();
			}
		}
	#endregion

	#region WINDOW
		/// @func window(_label, _width, _height, _x, _y, _callback, [_flags = EImGui_WindowFlags.NoCollapse + EImGui_WindowFlags.NoResize])
		/// @param {String} _label Title name of the window
		/// @param {String} _id This is the ID. Needs to be UNIQUE
		/// @param {Real} _x Position _x
		/// @param {Real} _y Position Y
		/// @param {Real} _width Width of window. Use 0 for auto fit
		/// @param {Real} _height Height of window. Use 0 for auto fit
		/// @param {Function} _callback Function to run when open
		/// @param _flags
		static window  = function(_label, _id, _x, _y, _width, _height, _callback, _flags = EImGui_WindowFlags.NoCollapse + EImGui_WindowFlags.NoResize) {
			imguigml_set_next_window_size(_width, _height);
			imguigml_set_next_window_pos(_x, _y);
		
			var ret = imguigml_begin(string(_label) + "###" + string(_id), undefined, _flags);
	
			if(ret[0] == 1) {
				_callback();
			}
			imguigml_end();
		}
	#endregion
	
	#region Colors
		/// @func color_edit(_label, _id, _red, _green, _blue, _on_change, [_flags = 0])
		/// @param {String} _label Title name of the window
		/// @param {String} _id This is the ID. Needs to be UNIQUE
		/// @param {Real} _color Blue value between 0 - 1
		/// @param {Function} _on_change The function to call when something changed
		/// @param {Real} _flags Flags from EImGui_ColorEditFlags
		static color_edit = function(_label, _id, _color, _on_change, _flags = 0) {
			if (context[$ _id] == undefined) context[$ _id] = {
				state: {
				    r: color_get_red(_color) / 255,
				    g: color_get_green(_color) / 255,
				    b: color_get_blue(_color) / 255
				}
			}
			
			var _state = context[$ _id].state;
			if (_state == undefined) {
				context[$ _id].state = {
				    r: color_get_red(_color) / 255,
				    g: color_get_green(_color) / 255,
				    b: color_get_blue(_color) / 255
				}
				
				_state = context[$ _id].state;
			}
			
		    // _state is a persistent struct like { r: 1, g: 0, b: 0 } that YOU own and keep alive
		    var ret = imguigml_color_edit3(string(_label) + "###" + string(_id), _state.r, _state.g, _state.b, _flags);
			
		    if (ret[0] == 1) {
		        _state.r = ret[1];
		        _state.g = ret[2];
		        _state.b = ret[3];
		        _on_change(make_colour_rgb(ret[1] * 255, ret[2] * 255, ret[3] * 255));
		    }
		}
		
		/// @func color_edit_alpha(_label, _id, _red, _green, _blue, _alpha, _on_change, [_flags = 0])
		/// @param {String} _label Title name of the window
		/// @param {String} _id This is the ID. Needs to be UNIQUE
		/// @param {Real} _red Red value between 0 - 1
		/// @param {Real} _green Green value between 0 - 1
		/// @param {Real} _blue Blue value between 0 - 1
		/// @param {Real} _alpha Alpha value between 0 - 1
		/// @param {Function} _on_change The function to call when something changed
		/// @param {Real} _flags Flags from EImGui_ColorEditFlags
		static color_edit_alpha = function(_label, _id, _red, _green, _blue, _alpha, _on_change, _flags = 0) {
			var ret = imguigml_color_edit4(string(_label) + "###" + string(_id), _red, _green, _blue, _alpha, _flags);
			
			
			
			if(ret[0] == 1) {
				_on_change(ret[1], ret[2], ret[3], ret[4]);
			}
		}
	#endregion
	
	#region Columns
		/// @func columns(id, ... columns)
		/// @param {String} id
		/// @param {Function} call back for each column
		static columns = function() {
			var column_count = argument_count - 1;
			imguigml_columns(column_count, argument[0]);
			
			for (var i = 0; i < column_count; i++) {
				argument[i + 1]();
			    imguigml_next_column();
			}
		}
	#endregion

	#region Labels
		/// @func label(_string)
		/// @desc Place a static label
		/// @param {String} _string The text to draw
		static label = function(_string) {
			imguigml_text(_string);
		}
	#endregion

	#region Text
		/// @func input_text(_label, _id, _text, _max_length, _on_change, [_callback = undefined], [_flags = 0], [_user_data = undefined])
		/// @param {String} _label Title name of the window
		/// @param {String} _id This is the ID. Needs to be UNIQUE
		/// @param {Real} _max_length Maximum length of input characters
		/// @param {Function} _on_change Function to call when changed
		/// @param {Function} _callback No idea
		/// @param {Any} _flags No idea
		/// @param {Any} _user_data No idea
		static input_text = function(_label, _id, _text, _max_length, _on_change, _callback = undefined, _flags = 0, _user_data = undefined) {
			var ret = imguigml_input_text(string(_label) + "###" + string(_id), _text, _max_length, _flags, _callback, _user_data)
			
			if(ret[0] == true) {
				_on_change(ret[1]);
			}
		}
	#endregion
	 
}