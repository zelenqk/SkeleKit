///@desc imguigml wrapper functions

function ImGuiWrapper() : ImGuiFunctions() constructor {
	#region cursor and layout functions
	
	///@function separator()
	///@desc separator, generally horizontal. inside a menu bar or in horizontal layout mode, this becomes a vertical separator.
	static separator = function(){
		if (!__imguigml_ext_call(_extImguiGML_separator()))
			return;
	}
	__ImguiIg(separator)
	
	///@function same_line([_pos_x=0.0], [_spacing_w=-1.0])
	///@desc call between widgets or groups to layout them horizontally
	///@param {Real} [_pos_x=0.0]
	///@param {Real} [_spacing_w=-1.0]
	static same_line = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0.0, ERousrData.Float);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : -1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_same_line()))
			return;
	}
	__ImguiIg(same_line)
	
	///@function new_line()
	///@desc undo a SameLine()
	static new_line = function(){
		if (!__imguigml_ext_call(_extImguiGML_new_line()))
			return;
	}
	__ImguiIg(new_line)
	
	///@function spacing()
	///@desc add vertical spacing
	static spacing = function(){
		if (!__imguigml_ext_call(_extImguiGML_spacing()))
			return;
	}
	__ImguiIg(spacing)
	
	///@function dummy(_size_x, _size_y)
	///@desc add a dummy item of given size
	///@param {Real} [_pos_x=0.0]
	///@param {Real} [_spacing_w=-1.0]
	static dummy = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument_count > 0 ? argument[0] : 0.0, ERousrData.Float);
		sr_buffer_write(buff, argument_count > 1 ? argument[1] : -1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_same_line()))
			return;
	}
	__ImguiIg(dummy)
	
	///@function indent([_index_w=0.0f])
	///@desc move content position toward the right, by style.IndentSpacing or indent_w if >0
	///@param {Real} [_index_w=0.0f]
	static indent = function(){
		sr_buffer_write(__Imgui_in, argument_count > 0 ? argument[0] : 0.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_indent()))
			return;
	}
	__ImguiIg(indent)
	
	///@function unindent([_index_w=0.0f])
	///@desc move content position back to the left, by style.IndentSpacing or indent_w if >0
	///@param {Real} [_index_w=0.0f]
	static unindent = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument_count > 0 ? argument[0] : 0.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_unindent()))
			return;
	}
	__ImguiIg(unindent)
	
	///@function begin_group()
	///@desc lock horizontal starting position + capture group bounding box into one "item" (so you can use IsItemHovered() or layout primitives such as SameLine() on whole group, etc.)
	static begin_group = function(){
		if (!__imguigml_ext_call(_extImguiGML_begin_group()))
			return;
	}
	__ImguiIg(begin_group)
	
	///@function end_group()
	///@desc end horizontal capture group 
	static end_group = function(){
		if (!__imguigml_ext_call(_extImguiGML_end_group()))
			return;
	}
	__ImguiIg(end_group)
	
	///@function get_cursor_pos()
	///@desc cursor position is relative to window position
	///@returns {Array:[x,y]}
	static get_cursor_pos = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_cursor_pos())) return;
		
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		
		return ret;
	}
	__ImguiIg(get_cursor_pos)
	
	///@function get_cursor_pos_x()
	///@desc cursor position is relative to window position
	///@returns {Real} x
	static get_cursor_pos_x = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_cursor_pos_x())) return;
		
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_cursor_pos_x)
	
	///@function get_cursor_pos_y()
	///@desc cursor position is relative to window position
	///@returns {Real} y
	static get_cursor_pos_y = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_cursor_pos_y())) return;
		
		var _buff = __imguigml_wrapper_buffer()
		return buffer_read(_buff, buffer_f32);
	}
	__ImguiIg(get_cursor_pos_y)
	
	///@function set_cursor_pos(_x, _y)
	///@desc set the imgui cursor position
	///@param {Real} _x
	///@param {Real} _y
	static set_cursor_pos = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		
		if (!__imguigml_ext_call(_extImguiGML_set_cursor_pos())) return;
	}
	__ImguiIg(set_cursor_pos)
	
	///@function set_cursor_pos_x(_x)
	///@desc set the imgui cursor position x
	///@param {Real} _x
	static set_cursor_pos_x = function(){
		sr_buffer_write(__Imgui_in, argument[0], ERousrData.Float);
		
		if (!__imguigml_ext_call(_extImguiGML_set_cursor_pos_x())) return;
	}
	__ImguiIg(set_cursor_pos_x)
	
	///@function set_cursor_pos_y(_y)
	///@desc set the imgui cursor position y
	///@param {Real} _y
	static set_cursor_pos_y = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		
		if (!__imguigml_ext_call(_extImguiGML_set_cursor_pos_y())) return;
	}
	__ImguiIg(set_cursor_pos_y)
	
	///@function get_cursor_start_pos()
	///@desc initial cursor position
	///@returns {Array:[x,y]}
	static get_cursor_start_pos = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_cursor_start_pos())) return;
		
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		
		return ret;
	}
	__ImguiIg(get_cursor_start_pos)
	
	///@function get_cursor_screen_pos()
	///@desc cursor position in absolute screen coordinates [0..io.DisplaySize] (useful to work with ImDrawList API)
	///@returns {Array:[x,y]}
	static get_cursor_screen_pos = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_cursor_screen_pos())) return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_cursor_screen_pos)
	
	///@function set_cursor_screen_pos(_x, _y)
	///@desc cursor position in absolute screen coordinates [0..io.DisplaySize]
	///@param {Real} _x
	///@param {Real} _y
	static set_cursor_screen_pos = function(){
		var buff = __imguigml_wrapper_buffer()
		
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_set_cursor_screen_pos())) return;
	}
	__ImguiIg(set_cursor_screen_pos)
	
	///@function align_text_to_frame_padding()
	///@desc vertically align/lower upcoming text to FramePadding.y so that it will aligns to upcoming widgets (call if you have text on a line before regular widgets)
	static align_text_to_frame_padding = function(){
		if (!__imguigml_ext_call(_extImguiGML_align_text_to_frame_padding())) return;
	}
	__ImguiIg(align_text_to_frame_padding)
	
	///@function get_text_line_height()
	///@desc height of font == GetWindowFontSize()
	///@returns {Real} height of font == GetWindowFontSize()
	static get_text_line_height = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_text_line_height())) return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_text_line_height)
	
	///@function get_text_line_height_with_spacing()
	///@desc distance (in pixels) between 2 consecutive lines of text == GetWindowFontSize() + GetStyle().ItemSpacing.y
	///@returns {Real} distance (in pixels) between 2 consecutive lines of text == GetWindowFontSize() + GetStyle().ItemSpacing.y
	static get_text_line_height_with_spacing = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_text_line_height_with_spacing())) return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_text_line_height_with_spacing)
	
	///@function get_frame_height()
	///@desc gets the height of the active frame [~ FontSize + style.FramePadding.y * 2]
	///@returns {Real}
	static get_frame_height = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_frame_height())) return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_frame_height)
	
	///@function get_frame_height_with_spacing()
	///@desc distance (in pixels) between 2 consecutive lines of standard height widgets == GetWindowFontSize() + GetStyle().FramePadding.y*2 + GetStyle().ItemSpacing.y
	///@returns {Real} distance (in pixels) between 2 consecutive lines of standard height widgets == GetWindowFontSize() + GetStyle().FramePadding.y*2 + GetStyle().ItemSpacing.y
	static get_frame_height_with_spacing = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_frame_height_with_spacing())) return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_frame_height_with_spacing)
	
	///@function columns([_count=1], [_id=undefined], [_border=true])
	///@desc You can also use SameLine(pos_x) for simplified columns. 
	///@param {Real} [_count=1]
	///@param {String} [_id=undefined]
	///@param {Boolean} [_border=true]
	static columns = function(){
		var in = __Imgui_in;
		var _id = argument_count > 1 ? argument[1] : undefined;
		_id = _id == undefined ? _id : noone;
	
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 1, ERousrData.Int32);
		sr_buffer_write(in, _id)
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 1, ERousrData.Int8);
	
		if (!__imguigml_ext_call(_extImguiGML_columns()))
			return;
	}
	__ImguiIg(columns)
	
	///@function next_column()
	///@desc next column, defaults to current row or next row if the current row is finished
	static next_column = function(){
		if (!__imguigml_ext_call(_extImguiGML_next_column()))
			return;
	}
	__ImguiIg(next_column)
	
	///@function get_column_index()
	///@desc get current column index
	///@returns {Real} column_index
	static get_column_index = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_column_index()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_column_index)
	
	///@function get_column_width([_column_index=-1])
	///@desc get column width (in pixels). pass -1 to use current column
	///@param {Real} [_column_index=-1]
	///@returns {Real} _column_width
	static get_column_width = function(){
		sr_buffer_write(__Imgui_in, argument_count > 0 ? argument[0] : -1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_get_column_width()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_column_width)
	
	///@function set_column_width(_column_index, _width)
	///@desc set column width (in pixels). pass -1 to use current column
	///@param {Real} _column_index   column to set width of (-1 for current)
	///@param {Real} _width          width in pixels to use
	static set_column_width = function(){
		var buff = __Imgui_in;
		sr_buffer_write(buff, argument[0], ERousrData.Int32);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_column_width());
	}
	__ImguiIg(set_column_width)
	
	///@function get_column_offset([_column_index=-1])
	///@desc get position of column line (in pixels, from the left side of the contents region).
	///@param {Real} [_column_index=-1]   pass -1 to use current column, otherwise 0..GetColumnsCount() inclusive. column 0 is typically 0.0f
	static get_column_offset = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument_count > 0 ? argument[0] : -1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_get_column_offset()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_column_offset)
	
	///@function set_column_offset(_column_index, _offset_x)
	///@desc set position of column line (in pixels, from the left side of the contents region).
	///@param {Real} _column_index   pass -1 to use current column
	///@param {Real} _offset_x       offset in pixels from the left side of the contents
	static set_column_offset = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_set_column_offset()))
			return;
	}
	__ImguiIg(set_column_offset)
	
	///@function get_columns_count()
	///@desc get amount of columns
	///@returns {Real} columns count
	static get_columns_count = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_columns_count()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_columns_count)
	
	#endregion
	#region drag n' drop functions
	
	///@function begin_drag_drop_source([_flags=0])
	///@desc call when the current item is active. If this return true, you can call set_drag_drop_payload() + end_drag_drop_target()
	///@param [_flags=0]
	static begin_drag_drop_source = function(){
		var _flags        = argument_count > 0 ? argument[0] : 0;
	
		var in = __Imgui_in;
		sr_buffer_write(in, _flags, ERousrData.Uint32);
		if (!__imguigml_ext_call(_extImguiGML_begin_drag_drop_source()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(begin_drag_drop_source)
	
	///@function set_drag_drop_payload(_type, _payload_id, [_flags=0])
	///@desc  pass an id to use to identify your payload data, or use the imgiugml_generate_payload / set_payload_data / release_payload_data helper functions
	///@param {String} _type                  type of payload. limited to 8 characters, starting with "_" is reserved for ImGui
	///@param {Real} _payload_id              id for your payload **NOTE: Converted to an integer, so don't use a floating point id**
	///@param {Real:EImGui_Cond} [_flags=0]   
	///@returns {Bool} to be quite frank, i'm not sure what it means
	static set_drag_drop_payload = function(_type, _payload_id, _flags = 0) {
		__ImguiIg(_flags)
		
		var in = __Imgui_in;
		// var type = string_copy(_type, 0, 8); // ensure 8 letters
		sr_buffer_write(in, _type, ERousrData.String);
		sr_buffer_write(in, _payload_id, ERousrData.Uint32);
		if (!__imguigml_ext_call(_extImguiGML_set_drag_drop_payload()))
			return;
			
		var out  = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(set_drag_drop_payload)
	
	///@function end_drag_drop_source()
	///@desc end the drag drop source
	static end_drag_drop_source = function(){
		__imguigml_ext_call(_extImguiGML_end_drag_drop_source());
	}
	__ImguiIg(end_drag_drop_source)
	
	///@function begin_drop_target()
	///@desc call after submitting an item that may receive an item. If this returns true, you can call AcceptDragDropPayload() + EndDragDropTarget()
	///@returns {Boolean} true on success
	static begin_drop_target = function(){
		__imguigml_ext_call(_extImguiGML_begin_drop_target());
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(begin_drop_target)
	
	///@function accept_drag_drop_payload(_type, [_flags=0])
	///@desc accept contents of a given type. If ImGuiDragDropFlags_AcceptBeforeDelivery is set you can peek into the payload before the mouse button is released.
	///@param {String} _type                  type of payload. limited to 8 characters, starting with "_" is reserved for ImGui
	///@param {Real:EImGui_Cond} [_flags=0]   
	///@returns {Array|undefined} undefined if no drop, else [ _payload, _is_preview, _is_delivery ] delivery is when we've released the mouse button, preview we are just hovering
	static accept_drag_drop_payload = function(){
		if (!__imguigml_ext_call(_extImguiGML_accept_drag_drop_payload()))
			return;
	
		var out = __Imgui_out, 
		    ret = undefined;
	
		var has_payload = buffer_read(out, buffer_s8) != 0;
		if (has_payload) {
			var payload_id  = buffer_read(out, buffer_u32);
			var is_preview  = buffer_read(out, buffer_s8) != 0;
			var is_delivery = buffer_read(out, buffer_s8) != 0;
	
			ret = [ payload_id, is_preview, is_delivery ];
		}
	
		return ret;
	}
	__ImguiIg(accept_drag_drop_payload)
	
	///@function end_drag_drop_target()
	///@desc end drag drop target
	static end_drag_drop_target = function(){
		__imguigml_ext_call(_extImguiGML_end_drag_drop_target());
	}
	__ImguiIg(end_drag_drop_target)
	
	///@function payload([_id], _payload_data)
	///@desc if an id is passed, use this id when looking up the payload, otherwise, return a generated id.
	///      these ids work by clearing each ImGui `NewFrame` and starting over again. generally, this should static fine, however, if you're having id misses in dragndrop,
	///      try just using your own unique id. 
	///@param {Real} [_id]   if a first param is passed, it's used as the id
	///@param {*} _payload_data   payload data can be anything and is returned with a `payload_get()`
	///@returns {Real} _id to pass to dragdrop functions
	static payload = function(){
		var _id      = argument_count > 1 ? argument[0] : undefined,
		    _payload = argument_count > 1 ? argument[1] : argument[0];
			
		var payload_data = ImGuiGML_PayloadData;
		var payloads = payload_data[EImGuiGML_PayloadData.Payloads];
	
		var set_id = _id;
		if (_id != undefined) {
			_id |= 1 << 31; // set the final bit to signify this is a user payload
			payloads = payload_data[EImGuiGML_PayloadData.UserPayloads];
		} else {
			set_id = payload_data[EImGuiGML_PayloadData.PayloadID];
			payload_data[@ EImGuiGML_PayloadData.PayloadID] = set_id + 1;
		}
	 
		payloads[@ set_id] = _payload;
		return _id;
	}
	__ImguiIg(payload)
	
	///@function payload_get(_id)
	///@desc return a payload given a passed _id.
	///@param {Real} _id
	///@returns {*} _payload_data 
	static payload_get = function(){
		var _id      = argument[0];
			
		var payload_data = ImGuiGML_PayloadData;
		var user_id = (_id & (1 << 31)) != 0;
	
		var payloads = payload_data[EImGuiGML_PayloadData.Payloads];
		if (user_id) {
			_id = _id & ~(1 << 31); // unset the final bit
			payloads = payload_data[EImGuiGML_PayloadData.UserPayloads];
		} 
	
		return payloads[@ _id];
	}
	__ImguiIg(payload_get)
	
	#endregion
	#region font functions
	
	///@function add_font_from_ttf(_file_path, [_font_size=10])
	///@desc Add font from a TTF file, passing the filepath to it. Returns a font index that can be checked for validity with `is_font_valid`
	///@param {String} _file_path
	///@param {Real} [_font_size=10]
	///@returns _font_index - use the font_index with push_font()
	static add_font_from_ttf = function(_file_path, _font_size = 10.0) {
		var _font_data = {
			filename: _file_path,
			fontsize: _font_size
		};
		
		if (!__imguigml_ext_call(_extImguiGML_reserve_font_index()))
			return;
	
		var out = __Imgui_out;
		var _index = buffer_read(out, buffer_f64)
		_font_data.index = _index;
		
		array_push(Deferred_fonts, _font_data);
	
		return _index;
	}
	__ImguiIg(add_font_from_ttf)
	
	///@function push_font(_font_index)
	///@desc use undefined as a shortcut to push default font
	static push_font = function(){
		var _font_index = argument_count > 0 ? argument[0] : undefined;
		if (_font_index == undefined) _font_index = -1;
		var _buff = __imguigml_wrapper_buffer()
		sr_buffer_write(_buff, _font_index);
	
		if (!__imguigml_ext_call(_extImguiGML_push_font())) 
			return;
	}
	__ImguiIg(push_font)
	
	///@function pop_font()
	///@desc pop the font
	static pop_font = function(){
		if (!__imguigml_ext_call(_extImguiGML_pop_font())) 
			return;
	}
	__ImguiIg(pop_font)
	
	///@function get_font()
	///@desc get current font (not implemented)
	///@returns {Real} _font_id
	static get_font = function(){
		//todo: implement font system
		//if (!__imguigml_ext_call(_extImguiGML_get_font();
	}
	__ImguiIg(get_font)
	
	///@function get_font_size()
	///@desc get current font size (= height in pixels) of current font with current scale applied
	///@returns {Real} current font size
	static get_font_size = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_font_size()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_font_size)
	
	///@function is_font_valid(_font_index)
	///@desc returns true if the font given is a valid font
	///@returns {Bool} is the font valid
	static is_font_valid = function(){
		var _font_index = argument_count > 0 ? argument[0] : undefined;
	
		var _buff = __imguigml_wrapper_buffer()
		sr_buffer_write(_buff, _font_index);
	
		if (!__imguigml_ext_call(_extImguiGML_is_font_valid()))
			return;
		
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_font_valid)
	
	///@function get_font_tex_uv_white_pixel()
	///@desc get UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API
	///@returns {Array:[u,v]}
	static get_font_tex_uv_white_pixel = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_font_tex_uv_white_pixel()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_font_tex_uv_white_pixel)
	
	#endregion
	#region id scope functions
	
	///@function push_id(_id, [_end_id])
	///@desc push identifier into the ID stack. IDs are hash of the entire stack!
	///@param {Real|String} _id   string or real id to push
	///@param {String} [_end_id]   last id to push
	static push_id = function(){
		var _buff = __imguigml_wrapper_buffer()
		var _id = argument[0];
		if (argument_count > 1) {
		  sr_buffer_write(_buff, string(_id));
		  sr_buffer_write(_buff, string(argument[1]));
		} else {
		  if (is_real(_id) || is_int32(_id) || is_int64(_id))
		    sr_buffer_write(_buff, _id, ERousrData.Int32);
		  else 
		    sr_buffer_write(_buff, string(_id));
		}
	
		__imguigml_ext_call(_extImguiGML_push_id());
	}
	__ImguiIg(push_id)
	
	///@function pop_id()
	///@desc pop identifier from ID stack
	static pop_id = function(){
		__imguigml_ext_call(_extImguiGML_pop_id());
	}
	__ImguiIg(pop_id)
	
	///@function get_id(_id, [_end_id])
	///@desc push identifier into the ID stack. IDs are hash of the entire stack!
	///@param {Real|String} _id    string or real id to get
	///@param {String} [_end_id]   last id to get
	///@returns {Real} ImGuiID
	static get_id = function(){
		var in = __imguigml_wrapper_buffer()
		var _id = argument[0];
		if (argument_count > 1) {
		  sr_buffer_write(in, string(_id));
		  sr_buffer_write(in, string(argument[1]));
		} else {
		  if (is_real(_id) || is_int32(_id) || is_int64(_id))
		    sr_buffer_write(in, _id, ERousrData.Int32);
		  else 
		    sr_buffer_write(in, string(_id));
		}
		if (!__imguigml_ext_call(_extImguiGML_get_id()))
			return;
	
		return buffer_read(__Imgui_out, buffer_u32);
	}
	__ImguiIg(get_id)
	
	#endregion
	#region io functions
	
	///@function get_clipboard_text()
	///@desc get the clipboard text
	///@return {String} clipboard text
	static get_clipboard_text = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_clipboard_text()))
			return;
		return buffer_read(__Imgui_out, buffer_string);
	}
	__ImguiIg(get_clipboard_text)
	
	///@function set_clipboard_text(_text)
	///@desc set the clipboard text
	static set_clipboard_text = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		__imguigml_ext_call(_extImguiGML_set_clipboard_text());
	}
	__ImguiIg(set_clipboard_text)
	
	///@function get_key_index(_key_index)
	///@desc get mapped index for imgui_key index, you really don't need this
	///@param {Real:__ImGuiKey_} _key_index
	///@returns {Real}
	static get_key_index = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_get_key_index()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_key_index)
	
	///@function is_key_down(_key_index)
	///@desc is key being held. == io.KeysDown[user_key_index]. note that imgui doesn't know the semantic of each entry of io.KeyDown[]. Use your own indices/enums according to how your backend/engine stored them into KeyDown[]!
	///@param {Real:__ImGuiKey_} _key_index
	///@returns {Boolean}
	static is_key_down = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_key_down()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_key_down)
	
	///@function is_key_pressed(_key_index, [_repeat=true])
	///@desc was key pressed (went from !Down to Down)
	///@param {Real:__ImGuiKey_} _key_index
	///@param {Boolean} [_repeat=true]        repeat=true, uses io.KeyRepeatDelay / KeyRepeatRate
	///@returns {Boolean}
	static is_key_pressed = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_key_pressed()))
			return;
		
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_key_pressed)
	
	///@function is_key_released(_key_index)
	///@desc is key released
	///@param {Real:__ImGuiKey_} _key_index
	///@returns {Boolean}
	static is_key_released = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_key_released()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_key_released)
	
	///@function get_key_pressed_amount(_key_index, _repeat_delay, _rate);
	///@desc uses provided repeat rate/delay. 
	///@param {Real} _key_index
	///@param {Real} _repeat_delay
	///@param {Real} _rate
	///@returns {Real} return a count, most often 0 or 1 but might be >1 if RepeatRate is small enough that DeltaTime > RepeatRate
	static get_key_pressed_amount = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		sr_buffer_write(in, argument[2], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_get_key_pressed_amount()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_key_pressed_amount)
	
	///@function is_mouse_down(_button)
	///@desc is mouse button held
	///@param {Real} _button
	///@returns {Boolean}
	static is_mouse_down = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_down()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_down)
	
	///@function is_mouse_clicked(_button, [_repeat=false])
	///@desc did mouse button clicked (went from !Down to Down)
	///@param {Real} _button
	///@param {Boolean} [_repeat=false]
	///@returns {Boolean}
	static is_mouse_clicked = function(){
		var in = __Imgui_in;
		var _repeat = argument_count > 1 ? argument[1] : false;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, _repeat ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_clicked()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_clicked)
	
	///@function is_mouse_double_clicked(_button)
	///@desc did mouse button double-clicked. a double-click returns false in IsMouseClicked(). uses io.MouseDoubleClickTime.
	///@param {Real} _button
	///@returns {Boolean}
	static is_mouse_double_clicked = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_double_clicked()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_double_clicked)
	
	///@function is_mouse_released(_button)
	///@desc did mouse button released (went from Down to !Down)
	///@param {Real} _button
	///@returns {Boolean}
	static is_mouse_released = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_released()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_released)
	
	///@function is_mouse_dragging([_button=0], [_lock_threadhold=-1.0])
	///@desc is mouse dragging. 
	///@param {Real} [_button=0]
	///@param {Real} [_lock_threshold=-1.0]   if lock_threshold < -1.0f uses io.MouseDraggingThreshold
	///@returns {Boolean}
	static is_mouse_dragging = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] :    0, ERousrData.Int32);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : -1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_dragging()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_dragging)
	
	///@function is_mouse_hovering_rect(_min_x, _min_y, _max_x, _max_y, [_clip=true])
	///@desc is mouse hovering given bounding rect (in screen space). 
	///@param {Real} _min_x
	///@param {Real} _min_y
	///@param {Real} _max_x
	///@param {Real} _max_y
	///@param {Boolean} [_clip=true]   clipped by current clipping settings. disregarding of consideration of focus/window ordering/blocked by a popup.
	///@returns {Boolean}
	static is_mouse_hovering_rect = function(){
		var in = __Imgui_in;
		var clipped = argument_count > 4 ? argument[4] : true;
	
		sr_buffer_write(in, argument[0], ERousrData.Float);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		sr_buffer_write(in, argument[2], ERousrData.Float);
		sr_buffer_write(in, argument[3], ERousrData.Float);
		sr_buffer_write(in, clipped ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_hovering_rect()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_mouse_hovering_rect)
	
	///@function is_mouse_pos_valid()
	///@desc is the mouse position valid
	///@returns {Boolean}
	static is_mouse_pos_valid = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_mouse_pos_valid()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) == 1;
	}
	__ImguiIg(is_mouse_pos_valid)
	
	///@function get_mouse_pos()
	///@desc shortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls
	///@returns {Boolean}
	static get_mouse_pos = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_mouse_pos()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_mouse_pos)
	
	///@function get_mouse_pos_on_opening_current_popup()
	///@desc retrieve backup of mouse positioning at the time of opening popup we have BeginPopup() into
	static get_mouse_pos_on_opening_current_popup = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_mouse_pos_on_opening_current_popup()))
			return;
		
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_mouse_pos_on_opening_current_popup)
	
	///@function get_mouse_drag_delta()
	///@desc retrieve backup of mouse positioning at the time of opening popup we have BeginPopup() into
	static get_mouse_drag_delta = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] :    0, ERousrData.Int32);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : -1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_get_mouse_drag_delta()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_mouse_drag_delta)
	
	///@function reset_mouse_drag_delta([_button=0])
	///@desc reset the drag delta
	///@param {Real} [_button=0]
	static reset_mouse_drag_delta = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_reset_mouse_drag_delta()))
			return;
	}
	__ImguiIg(reset_mouse_drag_delta)
	
	///@function get_mouse_cursor()
	///@desc get desired cursor type, reset in ImGui::NewFrame(), this is updated during the frame. valid before Render(). If you use software rendering by setting io.MouseDrawCursor ImGui will render those for you
	///@returns {Real:EImGui_MouseCursor} cursor id
	static get_mouse_cursor = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_mouse_cursor()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_mouse_cursor)
	
	///@function set_mouse_cursor(_type)
	///@desc set desired cursor type
	///@param {Real:EImGui_MouseCursor} _type
	static set_mouse_cursor = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_set_mouse_cursor()))
			return;
	}
	__ImguiIg(set_mouse_cursor)
	
	///@function capture_keyboard_from_app([_capture=true])
	///@desc manually override io.WantCaptureKeyboard flag next frame (said flag is entirely left for your application handle). e.g. force capture keyboard when your widget is being hovered.
	///@param {Boolean} [_capture=true]
	static capture_keyboard_from_app = function(){
		var in = __Imgui_in;
		var _capture = argument_count > 0 ? argument[0] : true;
		sr_buffer_write(in, _capture ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_capture_keyboard_from_app()))
			return;
	}
	__ImguiIg(capture_keyboard_from_app)
	
	///@function capture_mouse_from_app([_capture=true])
	///@desc manually override io.WantCaptureMouse flag next frame (said flag is entirely left for your application handle).
	///@param {Boolean} [_capture=true]
	static capture_mouse_from_app = function(){
		var in = __Imgui_in;
		var _capture = argument_count > 0 ? argument[0] : true;
		sr_buffer_write(in, _capture ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_capture_mouse_from_app()))
			return;
	}
	__ImguiIg(capture_mouse_from_app)
	
	#endregion
	#region logging functions
	
	///@function log_to_tty([_max_depth=-1])
	///@desc start logging to tty
	///@param {Real} [_max_depth=-1]
	static log_to_tty = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : -1, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_log_to_tty());
	}
	__ImguiIg(log_to_tty)
	
	///@function log_to_file([_max_depth=-1], [_file_name=undefined])
	///@desc start logging to file
	///@param {Real}   [_max_depth=-1]          
	///@param {String} [_file_name=undefined]   absolute path to log   
	static log_to_file = function(){
		var in = __Imgui_in;
		var _filename = argument_count > 1 ? argument[1] : undefined;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : -1, ERousrData.Int32);
		if (is_string(_filename)) sr_buffer_write(in, _filename);
		__imguigml_ext_call(_extImguiGML_log_to_tty());
	}
	__ImguiIg(log_to_file)
	
	///@function log_to_clipboard([_max_depth=-1])
	///@desc start logging to OS clipboard
	///@param {Real} [_max_depth=-1]
	static log_to_clipboard = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : -1, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_log_to_clipboard());
	}
	__ImguiIg(log_to_clipboard)
	
	///@function log_finish
	///@desc stop logging (close file, etc.)
	static log_finish = function(){
		if (!__imguigml_ext_call(_extImguiGML_log_finish()))
			return;
	}
	__ImguiIg(log_finish)
	
	///@function log_buttons()
	///@desc helper to display buttons for logging to tty/file/clipboard
	static log_buttons = function(){
		if (!__imguigml_ext_call(_extImguiGML_log_buttons()))
			return;
	}
	__ImguiIg(log_buttons)
	
	///@function log_text(_text)
	///@desc pass text data straight to log (without being displayed)
	///@param {String} _text
	static log_text = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		__imguigml_ext_call(_extImguiGML_log_text());
	}
	__ImguiIg(log_text)
	
	#endregion
	#region menu functions
	
	///@function begin_main_menu_bar()
	///@desc create and append to a full screen menu-bar. only call EndMainMenuBar() if this returns true!
	///@returns {Boolean}
	static begin_main_menu_bar = function(){
		if (!__imguigml_ext_call(_extImguiGML_begin_main_menu_bar()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) == 1;
	}
	__ImguiIg(begin_main_menu_bar)
	
	///@function end_main_menu_bar()
	///@desc end main menu bar
	static end_main_menu_bar = function(){
		__imguigml_ext_call(_extImguiGML_end_main_menu_bar());
	}
	__ImguiIg(end_main_menu_bar)
	
	///@function begin_menu_bar()
	///@desc append to menu-bar of current window (requires ImGuiWindowFlags_MenuBar flag set on parent window). only call EndMenuBar() if this returns true!
	///@returns {Boolean}
	static begin_menu_bar = function(){
		if (!__imguigml_ext_call(_extImguiGML_begin_menu_bar()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) == 1;
	}
	__ImguiIg(begin_menu_bar)
	
	///@function end_menu_bar()
	///@desc end menu bar
	static end_menu_bar = function(){
		__imguigml_ext_call(_extImguiGML_end_menu_bar());
	}
	__ImguiIg(end_menu_bar)
	
	///@function begin_menu(_label, [_enabled=true]);
	///@desc create a sub-menu entry. only call EndMenu() if this returns true!
	///@param {String} _label          
	///@param {Boolean} [_enabled=true]
	///@returns {Boolean}
	static begin_menu = function(){
		var in = __Imgui_in;
		var _enabled = argument_count > 1 ? argument[1] : true;
		sr_buffer_write(in, argument[0]);
		sr_buffer_write(in, _enabled ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_begin_menu()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(begin_menu)
	
	///@function end_menu()
	///@desc end sub-menu entry
	static end_menu = function(){
		if (!__imguigml_ext_call(_extImguiGML_end_menu()))
			return;
	}
	__ImguiIg(end_menu)
	
	///@function menu_item(_label, [_shortcut=""], [_selected=false], [_enabled=true]);
	///@desc show a sub-menu item
	///@param {String} _label
	///@param {String} [_shortcut=""]       shortcuts are displayed for convenience but not processed by ImGui at the moment
	///@param {Boolean} [_selected=false]  
	///@param {Boolean} [_enabled=true] 
	///@returns {Boolean} true when activated. 
	static menu_item = function(){
		var in = __Imgui_in;
		var _selected = argument_count > 2 ? argument[2] : false;
		var _enabled  = argument_count > 3 ? argument[3] : true;
	
		sr_buffer_write(in, string(argument[0]));
		sr_buffer_write(in, string(argument_count > 1 ? argument[1] : ""));
		sr_buffer_write(in, _selected ? 1 : 0, ERousrData.Int8);
		sr_buffer_write(in, _enabled ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_menu_item()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(menu_item)
	
	///@function open_popup(_str_id)
	///@desc call to mark popup as open (don't call every frame!). popups are closed when user click outside, 
	///      or if CloseCurrentPopup() is called within a BeginPopup()/EndPopup() block. By default, 
	///      Selectable()/MenuItem() are calling CloseCurrentPopup(). Popup identifiers are relative to the 
	///      current ID-stack (so OpenPopup and BeginPopup needs to be at the same level).
	///@param {String} _str_id
	static open_popup = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		if (!__imguigml_ext_call(_extImguiGML_open_popup()))
			return;
	}
	__ImguiIg(open_popup)
	
	///@function open_popup_on_item_click([_str_id=undefined], [_mouse_button=1])
	///@desc helper to open popup when clicked on last item. 
	///@param {String} [_str_id=undefined]
	///@param {Real} [_mouse_button=1]
	static open_popup_on_item_click = function(){
		var in = __Imgui_in;
		var str_id = argument_count > 0 ? argument[0] : noone;
		if (!is_string(str_id)) str_id = noone;
		sr_buffer_write(in, str_id);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_open_popup_on_item_click()))
			return;
	}
	__ImguiIg(open_popup_on_item_click)
	
	///@function begin_popup(_str_id)
	///@desc begin a pop up - only call EndPopup() if BeginPopup() returned true!
	///@param {String} _str_id
	///@returns {Boolean} true if the popup is open, and you can start outputting to it. 
	static begin_popup = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		if (!__imguigml_ext_call(_extImguiGML_begin_popup()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(begin_popup)
	
	///@function begin_popup_modal(_name, [_open=undefined], [_extra_flags=0])
	///@desc modal dialog (block interactions behind the modal window, can't close the modal window by clicking outside)
	///@param {String} _name
	///@param {Boolean} [_open=undefined] if passed, a close button is shown if true, or its closed if false, returns array with second value being if its open still
	///@param {Real:EImGui_WindowFlags} [_extra_flags=0]
	///@returns {Boolean|Array:[Boolean, Boolean]} if `_open` is passed, then an array for [ BeginPopupModal, _open ]
	static begin_popup_modal = function(){
		var in = __Imgui_in;
	
		var _open = argument_count > 1 ? argument[1] : undefined;
		if (_open == noone) _open = undefined;
		var do_open = _open == undefined;
		sr_buffer_write(in, string(argument[0]));
		if (_open != undefined)
		  sr_buffer_write(in, _open ? 1 : 0, ERousrData.Int8)
		else 
		  sr_buffer_write(in, " ");
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_begin_popup_modal()))
			return;
		var out = __Imgui_out;
		if (do_open) {
			var ret = array_create(2);
			ret[@ 0] = buffer_read(out, buffer_s8);
			ret[@ 1] = buffer_read(out, buffer_s8);
			return ret;
		} 
	
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(begin_popup_modal)
	
	///@function begin_popup_context_item([_str_id=undefined], [_mouse_button=1])
	///@desc helper to open and begin popup when clicked on last item. if you can pass a NULL str_id only if the previous item had an id. If you want to use that on a non-interactive item such as Text() you need to pass in an explicit ID here. read comments in .cpp!
	///@param {String} [_str_id=undefined]   if you can pass an `undefined` `_str_id` only if the previous item had an id. If you want to use that on a non-interactive item such as Text() you need to pass in an explicit ID here.
	///@param {Real}   [_mouse_button=1]     
	///@returns {Boolean}
	static begin_popup_context_item = function(){
		var in = __Imgui_in;
		var str_id = argument_count > 0 ? argument[0] : noone;
		if (!is_string(str_id)) str_id = noone;
	
		sr_buffer_write(in, str_id);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 1, ERousrData.Int32);
	
		if (!__imguigml_ext_call(_extImguiGML_begin_popup_context_item()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(begin_popup_context_item)
	
	///@function begin_popup_context_window([_str_id=undefined], [_mouse_button=1], [_also_over_items=true])
	///@desc helper to open and begin popup when clicked on current window.
	///@param {String} [_str_id=undefined]
	///@param {Real} [_mouse_button=1]
	///@param {Boolean} [_also_over_items=true]
	///@returns {Boolean}
	static begin_popup_context_window = function(){
		var in = __Imgui_in;
		var str_id = argument_count > 0 ? argument[0] : noone;
		if (!is_string(str_id)) str_id = noone;
		var also_over_items = argument_count > 2 ? argument[2] : true;
	
		sr_buffer_write(in, str_id);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 1, ERousrData.Int32);
		sr_buffer_write(in, also_over_items ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_begin_popup_context_window()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(begin_popup_context_window)
	
	///@function begin_popup_context_void([_str_id=undefined], [_mouse_button=1])
	///@desc helper to open and begin popup when clicked in void (where there are no imgui windows).
	///@param {String} [_str_id=undefined]
	///@param {Real} [_mouse_button=1]
	///@returns {Boolean}
	static begin_popup_context_void = function(){
		var in = __Imgui_in;
		var str_id = argument_count > 0 ? argument[0] : noone;
		if (!is_string(str_id)) str_id = noone;
		sr_buffer_write(in, str_id);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_begin_popup_context_void()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(begin_popup_context_void)
	
	///@function end_popup()
	///@desc end the current pop up
	static end_popup = function(){
		if (!__imguigml_ext_call(_extImguiGML_end_popup()))
			return;
	}
	__ImguiIg(end_popup)
	
	///@function is_popup_open(_str_id)
	///@desc return true if the popup is open
	///@param {String} _str_id
	///@returns {Boolean}
	static is_popup_open = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, string(argument[0]));
		if (!__imguigml_ext_call(_extImguiGML_is_popup_open()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_popup_open)
	
	///@function close_current_popup()
	///@desc close the popup we have begin-ed into. clicking on a MenuItem or Selectable automatically close the current popup.
	static close_current_popup = function(){
		__imguigml_ext_call(_extImguiGML_close_current_popup());
	}
	__ImguiIg(close_current_popup)
	
	#endregion
	#region parameter stack functions
	
	///@function push_style_color(_idx, _colOrR, [_g], [_b], [_a])
	///@desc
	///@param {Real:EImGui_Col} _idx    
	///@param {Real} _colOrR if passing a single color, treated as a U32 colors
	///@param {Real} [_g]    
	///@param {Real} [_b]    
	///@param {Real} [_a]    
	static push_style_color = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (argument_count == 2)
		  sr_buffer_write(in, argument[1], ERousrData.Uint32);
		else {
		  sr_buffer_write(in, argument[1], ERousrData.Float);
		  sr_buffer_write(in, argument[2], ERousrData.Float);
		  sr_buffer_write(in, argument[3], ERousrData.Float);
		  sr_buffer_write(in, argument[4], ERousrData.Float);
		}
	
		__imguigml_ext_call(_extImguiGML_push_style_color());
	}
	__ImguiIg(push_style_color)
	
	///@function pop_style_color([_count=1])
	///@desc pop style colors
	///@param {Real} [_count=1]
	static pop_style_color = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_pop_style_color()))
			return;
	}
	__ImguiIg(pop_style_color)
	
	///@function push_style_var
	///@desc push a style var on the param stack
	///@param {Real:EImGui_StyleVar} _idx 
	///@param {Real} _valOrX  
	///@param {Real} [_y]     if passed, treat the values as a vec2
	static push_style_var = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		if (argument_count > 2)
		  sr_buffer_write(in, argument[2], ERousrData.Float);
	
		__imguigml_ext_call(_extImguiGML_push_style_var());
	}
	__ImguiIg(push_style_var)
	
	///@function pop_style_var([_count=1])
	///@desc pop style colors
	///@param {Real} [_count=1]
	static pop_style_var = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 1, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_pop_style_var());
	}
	__ImguiIg(pop_style_var)
	
	///@function get_style_color_vec4(_idx)
	///@desc retrieve style color as stored in ImGuiStyle structure. use to feed back into PushStyleColor(), otherwhise use GetColorU32() to get style color + style alpha.
	///@param {Real:EImGui_Col} _idx    
	///@returns {Array:[r,g,b,a]}
	static get_style_color_vec4 = function(){
		sr_buffer_write(__Imgui_in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_get_style_color_vec4()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(4);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		ret[@ 2] = buffer_read(out, buffer_f32);
		ret[@ 3] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_style_color_vec4)
	
	///@function get_color_u32(_colOrR, [_g], [_b], [_a])
	///@desc retrieve given style color with style alpha applied and optional extra alpha multiplier
	///@param {Real} _colOrR   U32 color, or r component
	///@param {Real} [_g]      g component
	///@param {Real} [_b]      b component
	///@param {Real} [_a]      a component
	static get_color_u32 = function(){
		var in = __Imgui_in;
		if (argument_count == 1)
		  sr_buffer_write(in, argument[0], ERousrData.Uint32);
		else {
		  sr_buffer_write(in, argument[0], ERousrData.Float);
		  sr_buffer_write(in, argument[1], ERousrData.Float);
		  sr_buffer_write(in, argument[2], ERousrData.Float);
		  sr_buffer_write(in, argument[3], ERousrData.Float);
		}
		if (!__imguigml_ext_call(_extImguiGML_get_color_u32()))
			return;
		return buffer_read(__Imgui_out, buffer_u32);
	}
	__ImguiIg(get_color_u32)
	
	///@function get_color_u32_from_idx(_idx, [_alpha_mul=1.0])
	///@desc retrieve given style color with style alpha applied and optional extra alpha multiplier
	///@param {Real:EImGui_Col} _idx
	///@param {Real} [_alpha_mul=1.0]
	static get_color_u32_from_idx = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_get_color_u32()))
			return;
		return buffer_read(__Imgui_out, buffer_u32);
	}
	__ImguiIg(get_color_u32_from_idx)
	
	///@function push_item_width(_item_width)
	///@desc width of items for the common item+label case, pixels. 
	///@param {Real} _item_width   0.0f = default to ~2/3 of windows width, >0.0f: width in pixels, <0.0f align xx pixels to the right of window (so -1.0f always align width to the right side)
	static push_item_width = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_push_item_width());
	}
	__ImguiIg(push_item_width)
	
	///@function pop_item_width()
	///@desc pop item width
	static pop_item_width = function(){
		__imguigml_ext_call(_extImguiGML_pop_item_width());
	}
	__ImguiIg(pop_item_width)
	
	///@function calc_item_width()
	///@desc width of item given pushed settings and current cursor position
	///@returns {Real}
	static calc_item_width = function(){
		if (!__imguigml_ext_call(_extImguiGML_calc_item_width()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(calc_item_width)
	
	///@function push_text_wrap_pos([_wrap_pos_x=0.0])
	///@desc word-wrapping for Text*() commands. 
	///@param {Real} [_wrap_pos_x=0.0]    < 0.0f: no wrapping; 0.0f: wrap to end of window (or column); > 0.0f: wrap at 'wrap_pos_x' position in window local space
	static push_text_wrap_pos = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0.0, ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_push_text_wrap_pos());
	}
	__ImguiIg(push_text_wrap_pos)
	
	///@function pop_text_wrap_pos()
	///@desc pop text wrap pos
	static pop_text_wrap_pos = function(){
		__imguigml_ext_call(_extImguiGML_pop_text_wrap_pos());
	}
	__ImguiIg(pop_text_wrap_pos)
	
	///@function push_allow_keyboard_focus(_allow_keyboard_focus)
	///@desc allow focusing using TAB/Shift-TAB, enabled by default but you can disable it for certain widgets
	///@param {Boolean} _allow_keyboard_focus   
	static push_allow_keyboard_focus = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0] ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_push_allow_keyboard_focus()))
			return;
	}
	__ImguiIg(push_allow_keyboard_focus)
	
	///@function pop_allow_keyboard_focus()
	///@desc pop allow keyboard focus
	static pop_allow_keyboard_focus = function(){
		__imguigml_ext_call(_extImguiGML_pop_allow_keyboard_focus());
	}
	__ImguiIg(pop_allow_keyboard_focus)
	
	///@function push_button_repeat(_repeat)
	///@desc in 'repeat' mode, Button*() functions return repeated true in a typematic manner (using io.KeyRepeatDelay/io.KeyRepeatRate setting). Note that you can call IsItemActive() after any Button() to tell if the button is held in the current frame.
	///@param {Boolean} _repeat
	static push_button_repeat = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0] ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_push_button_repeat()))
			return;
	}
	__ImguiIg(push_button_repeat)
	
	///@function pop_button_repeat()
	///@desc pop repeat mode
	static pop_button_repeat = function(){
		__imguigml_ext_call(_extImguiGML_pop_button_repeat());
	}
	__ImguiIg(pop_button_repeat)
	
	#endregion
	#region selectable list functions
	
	///@function selectable(_label, [_selected=false], [_selectable_flags=0], [_size_x=0], [_size_y=0])
	///@desc selectable element
	///@param {String}                      _label   
	///@param {Boolean}                     [_selected=false]
	///@param {Real:EImGui_SelectableFlags} [_selectable_flags=0]
	///@param {Real}                        [_size_x=0]            size.x==0.0: use remaining width, size.x>0.0: specify width.
	///@param {Real}                        [_size_y=0]            size.y==0.0: use label height, size.y>0.0: specify height
	///@returns {Array:[_val_changes, _is_selected]}
	static selectable = function(){
		var in = __Imgui_in;
		var _selected = argument_count > 1 ? argument[1] : false;
	
		sr_buffer_write(in, string(argument[0]));
		sr_buffer_write(in, _selected ? 1 : 0, ERousrData.Int8);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0, ERousrData.Int32);
		sr_buffer_write(in, argument_count > 4 ? argument[3] : 0, ERousrData.Float);
		sr_buffer_write(in, argument_count > 4 ? argument[4] : 0, ERousrData.Float);
	
		if (!__imguigml_ext_call(_extImguiGML_selectable()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_s8) != 0;
		ret[@ 1] = buffer_read(out, buffer_s8) != 0;
		return ret;
	}
	__ImguiIg(selectable)
	
	///@function list_box(_label, _current_item, _item_array, [_height_in_items=-1])
	///@desc create a list box
	///@param {String} _label 
	///@param {Real} _current_item
	///@param {Array:String} _item_array
	///@param {Real} [_height_in_items=-1])
	///@returns {Array:[{Boolean} _changed, {Real} _selected_index]}
	static list_box = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		sr_buffer_write(in, argument[1], ERousrData.Int32);
	
		var _items = argument[2];
		var num_items = array_length(_items);
		sr_buffer_write(in, num_items, ERousrData.Int32);
		for (var i = 0; i < num_items; ++i) 
		  sr_buffer_write(in, string(_items[i]));
	
		sr_buffer_write(in, argument_count > 3 ? argument[3] : -1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_list_box()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_s8) != 0;
		ret[@ 1] = buffer_read(out, buffer_s32);
		return ret;
	}
	__ImguiIg(list_box)
	
	///@function list_box_header(_label, _size_x, _size_y)
	///@desc use if you want to reimplement ListBox() will custom data or interactions. make sure to call ListBoxFooter() afterwards.
	///@param {String} _label
	///@param {Real} _size_x
	///@param {Real} _size_y
	///@returns {Boolean}
	static list_box_header = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, string(argument[0]));
		sr_buffer_write(in, argument[1], ERousrData.Float);
		sr_buffer_write(in, argument[2], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_list_box_header()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(list_box_header)
	
	///@function list_box_header_items(_label, _items_count,  [_height_in_items=-1]);
	///@desc use if you want to reimplement ListBox() will custom data or interactions. make sure to call ListBoxFooter() afterwards.
	///@param {String} _label
	///@param {Real} _items_count
	///@param {Real} [_height_in_items=-1]
	///@returns {Boolean}
	static list_box_header_items = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, string(argument[0]));
		sr_buffer_write(in, argument[1], ERousrData.Int32);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : -1, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_list_box_header()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(list_box_header_items)
	
	///@function list_box_footer()
	///@desc terminate the scrolling region
	static list_box_footer = function(){
		__imguigml_ext_call(_extImguiGML_list_box_footer());
	}
	__ImguiIg(list_box_footer)
	
	#endregion
	#region style functions
	
	///@function show_style_editor()
	///@desc add style editor block (not a window). you can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it uses the default style)
	static show_style_editor = function(){
		// todo: style index
		if (!__imguigml_ext_call(_extImguiGML_show_style_editor()))
			return;
	}
	__ImguiIg(show_style_editor)
	
	///@function style_colors_classic()
	///@desc use classic colors
	static style_colors_classic = function(){
		// todo: style index
		if (!__imguigml_ext_call(_extImguiGML_style_colors_classic()))
			return;
	}
	__ImguiIg(style_colors_classic)
	
	///@function style_colors_dark()
	///@desc use dark colors
	static style_colors_dark = function(){
		// todo: style index
		if (!__imguigml_ext_call(_extImguiGML_style_colors_dark()))
			return;
	}
	__ImguiIg(style_colors_dark)
	
	///@function style_colors_light()
	///@desc use light colors
	static style_colors_light = function(){
		// todo: style index
		if (!__imguigml_ext_call(_extImguiGML_style_colors_light()))
			return;
	}
	__ImguiIg(style_colors_light)
	
	///@function show_style_selector(_label)
	///@desc show the style selector widget
	///@param {String} _label
	static show_style_selector = function(){
		var _label = argument[0];
		var in = __Imgui_in;
		sr_buffer_write(in, _label, ERousrData.String);
		if (!__imguigml_ext_call(_extImguiGML_show_style_selector()))
			return;
	}
	__ImguiIg(show_style_selector)
	
	#endregion
	#region tab functions
	
	///@function begin_tab_bar(_std_id, [_flags=0])
	///@desc start a tab bar
	///@param {String} _std_id
	///@param {Real:EImGui_TabBarFlags} [_flags=0]
	static begin_tab_bar = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.String);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_begin_tab_bar());
	}
	__ImguiIg(begin_tab_bar)
	
	///@function end_tab_bar()
	///@desc finish a tab bar
	static end_tab_bar = function(){
		__imguigml_ext_call(_extImguiGML_end_tab_bar());
	}
	__ImguiIg(end_tab_bar)
	
	///@function begin_tab_item(_name, [_open=undefined], [_flags=0])
	///@desc create a tab item
	///@param {String} _name                         name for tab item
	///@param {Real} [_open=undefined]               pass true/false for if this window is open w/close button, undefined for no button
	///@param {Real:EImGui_TabItemFlags} [_flags=0]  tab item flags
	///@returns {Array:[_selected, [_is_open])
	static begin_tab_item = function(){
		var in = __Imgui_in;
		var _name  = argument[0],
		    _open  = argument_count > 1 ? argument[1] : undefined,
		    _flags = argument_count > 2 ? argument[2] : 0;
	
		if (_open != undefined) _open = _open ? 1 : 0;
	
		sr_buffer_write(in, _name);
		sr_buffer_write(in, _open == undefined ? 0 : _open, _open == undefined ? ERousrData.Float : ERousrData.Int8);
		sr_buffer_write(in, _flags, ERousrData.Int32);
	
		if (!__imguigml_ext_call(_extImguiGML_begin_tab_item()))
			return;
		
		var out = __Imgui_out;
		var ret = [ buffer_read(out, buffer_s8) != 0 ];
		if (_open != undefined)
		  ret[@ 1] = buffer_read(out, buffer_s8) != 0;
	
		return ret;
	}
	__ImguiIg(begin_tab_item)
	
	///@function end_tab_item()
	///@desc end a tab item
	static end_tab_item = function(){
		__imguigml_ext_call(_extImguiGML_end_tab_item());
	}
	__ImguiIg(end_tab_item)
	
	///@function set_tab_item_closed(_name)
	///@desc set a tab item as closed
	///@param {String} _name
	static set_tab_item_closed = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		__imguigml_ext_call(_extImguiGML_set_tab_item_closed());
	}
	__ImguiIg(set_tab_item_closed)
	
	///@function set_tab_item_selected(_name)
	///@desc set a tab item as selected
	///@param {String} _name
	static set_tab_item_selected = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		if (!__imguigml_ext_call(_extImguiGML_set_tab_item_selected()))
			return;
	}
	__ImguiIg(set_tab_item_selected)
	
	#endregion
	#region texteditor functions
	
	///@function texteditor_create()
	///@desc create a new texteditor
	static texteditor_create = function(){
		if (!__imguigml_ext_call(_extImguiGML_texteditor_create()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_f64);
	}
	__ImguiIg(texteditor_create)
	
	///@function texteditor_destroy(_editor)
	///@desc destroy a texteditor
	///@param {Real} _editor_index
	///@returns {undefined} so you can chain calls
	static texteditor_destroy = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi], ERousrData.Double);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_destroy()))
			return;
		return undefined;
	}
	__ImguiIg(texteditor_destroy)
	
	///@function texteditor_set_language_definition(_editor_index)
	///@desc Sets the current text editor language definition
	///@param {Real} _editor_index 
	///@param {String} _lang         can be "CPlusPlus", "HLSL", "GLSL", "C", "SQL", or "Lua"
	static texteditor_set_language_definition = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Uint32);
		sr_buffer_write(in, argument[1]);
		var ret = _extImguiGML_texteditor_set_language_definition();
		if (ret == -3) 
		  show_debug_message("texteditor_set_language_definition: couldn't find lang: " + string(argument[1]));
	}
	__ImguiIg(texteditor_set_language_definition)
	
	///@function texteditor_get_language_definition(_editor_index)
	///@desc Gets the current text editor language definition
	///@param {Real} _editor_index 
	///@returns {String} lang def
	static texteditor_get_language_definition = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_language_definition()))
			return;
		return buffer_read(__Imgui_out, buffer_string);
	}
	__ImguiIg(texteditor_get_language_definition)
	
	///@function texteditor_get_palette(_editor_index)
	///@desc Gets the palette of the current text editor
	///@param {Real} _editor_index 
	///@returns {Array:EImGuiText_Palette} filled in array with current palette colors
	static texteditor_get_palette = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Uint32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_palette()))
			return;
		var out = __Imgui_out;
		var palette = array_create(EImGuiText_Palette.Num, 0);
		var i = 0; repeat(EImGuiText_Palette.Num)
		  palette[@i++] = buffer_read(out, buffer_u8);
		return palette;
	}
	__ImguiIg(texteditor_get_palette)
	
	///@function texteditor_set_palette(_editor_index, _palette)
	///@desc Sets the palette of the current text editor
	///@param {Real} _editor_index 
	///@param {Array:EImGuiText_Palette} _palette   note - GetDark/Light palette will give you basic one
	static texteditor_set_palette = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Uint32);
		var palette = array_create(EImGuiText_Palette.Num, 0);
		var i = 0; repeat(EImGuiText_Palette.Num)
		  sr_buffer_write(in, palette[i], buffer_u8);
	
		if (!__imguigml_ext_call(_extImguiGML_texteditor_set_palette()))
			return;
	}
	__ImguiIg(texteditor_set_palette)
	
	///@function texteditor_render(_editor_index, _label, [_size_x=0], [_size_y=0], [_border=false])
	///@desc Renders the text editor
	///@param {Real} _editor_index 
	///@param {String} _label
	///@param {Real} [_size_x=0]
	///@param {Real} [_size_y=0]
	///@param {Boolean} [_border=false]
	static texteditor_render = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.String);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : 0, ERousrData.Float); argi++;
		sr_buffer_write(in, argument_count > argi ? argument[argi] : 0, ERousrData.Float); argi++;
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool);  argi++;
		if (!__imguigml_ext_call(_extImguiGML_texteditor_render()))
			return;
	}
	__ImguiIg(texteditor_render)
	
	///@function texteditor_set_text(_editor_index, _text)
	///@desc Sets the text of the current editor 
	///@param {Real} _editor_index 
	///@param {String} _text
	static texteditor_set_text = function(argument0, argument1) {
		__imguigml_ext_call(_extImguiGML_texteditor_set_text(argument0, argument1)); // special case, we just use the DLL API since buffers can be HUGE!
	}
	__ImguiIg(texteditor_set_text)
	
	///@function texteditor_get_text(_editor_index)
	///@desc Gets the text from the current editor 
	///@param {Real} _editor_index 
	///@returns {String} 
	static texteditor_get_text = function(argument0) {
		return _extImguiGML_texteditor_get_text(argument0); // special case - text buffers can be huge so we just use the direct DLL API.
	}
	__ImguiIg(texteditor_get_text)
	
	///@function texteditor_get_selected_text(_editor_index)
	///@desc Gets the selected text of the current editor 
	///@param {Real} _editor_index 
	///@returns {String}
	static texteditor_get_selected_text = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_selected_text()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_string);
	}
	__ImguiIg(texteditor_get_selected_text)
	
	///@function texteditor_get_total_lines(_editor_index)
	///@desc Gets the total lines from the current text editor
	///@param {Real} _editor_index 
	///@returns {Real}
	static texteditor_get_total_lines = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_total_lines()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s32);
	}
	__ImguiIg(texteditor_get_total_lines)
	
	///@function texteditor_is_overwrite(_editor_index)
	///@desc Checks if current text editor is in overwrite mode
	///@param {Real} _editor_index 
	///@returns {Boolean}
	static texteditor_is_overwrite = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_is_overwrite()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(texteditor_is_overwrite)
	
	///@function texteditor_set_readonly(_editor_index, _value)
	///@desc Sets the text editor to read only
	///@param {Real} _editor_index 
	///@param {Boolean} _value
	static texteditor_set_readonly = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Bool);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_set_read_only()))
			return;
	}
	__ImguiIg(texteditor_set_readonly)
	
	///@function texteditor_is_readonly(_editor_index)
	///@desc Checks if the current editor is read only
	///@param {Real} _editor_index 
	///@returns {Boolean}
	static texteditor_is_readonly = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_is_read_only()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(texteditor_is_readonly)
	
	///@function texteditor_set_cursor_position(_editor_index, _line, _col)
	///@desc Sets the cursor position using line and column
	///@param {Real} _editor_index 
	///@param {Real} _line
	///@param {Real} _col
	static texteditor_set_cursor_position = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_set_cursor_position());
	}
	__ImguiIg(texteditor_set_cursor_position)
	
	///@function texteditor_get_cursor_position(_editor_index)
	///@desc Gets the line and column from the current text editor 
	///@param {Real} _editor_index 
	///@returns {Array:[_line, _col]}
	static texteditor_get_cursor_position = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_cursor_position()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_u32);
		ret[@ 1] = buffer_read(out, buffer_u32);
		return ret;
	}
	__ImguiIg(texteditor_get_cursor_position)
	
	///@function texteditor_insert_text(_editor_index, _text)
	///@desc Inserts text at position in the current text editor
	///@param {Real} _editor_index 
	///@param {String} _text
	static texteditor_insert_text = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.String);
		__imguigml_ext_call(_extImguiGML_texteditor_insert_text());
	}
	__ImguiIg(texteditor_insert_text)
	
	///@function texteditor_move_up(_editor_index, _amount, [_select = false])
	///@desc Moves up  lines in the text editor
	///@param {Real} _editor_index 
	///@param {Real} _amount
	///@param {Real} [_select = false]
	static texteditor_move_up = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_up());
	}
	__ImguiIg(texteditor_move_up)
	
	///@function texteditor_move_down(_editor_index, _amount, [_select = false])
	///@desc Moves down  lines in the text editor
	///@param {Real} _editor_index 
	///@param {Real} _amount
	///@param {Real} [_select = false]
	static texteditor_move_down = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_down());
	}
	__ImguiIg(texteditor_move_down)
	
	///@function texteditor_move_left(_editor_index, _amount, [_select = false])
	///@desc Moves left  lines in the text editor
	///@param {Real} _editor_index 
	///@param {Real} _amount
	///@param {Real} [_select = false]
	static texteditor_move_left = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_left());
	}
	__ImguiIg(texteditor_move_left)
	
	///@function texteditor_move_right(_editor_index, _amount, [_select = false])
	///@desc Moves right  lines in the text editor
	///@param {Real} _editor_index 
	///@param {Real} _amount
	///@param {Real} [_select = false]
	static texteditor_move_right = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_right());
	}
	__ImguiIg(texteditor_move_right)
	
	///@function texteditor_move_top(_editor_index, [_select = false])
	///@desc Skips to top of current editor 
	///@param {Real} _editor_index 
	///@param {Real} [_select = false]
	static texteditor_move_top = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_top());
	}
	__ImguiIg(texteditor_move_top)
	
	///@function texteditor_move_bottom(_editor_index, [_select = false])
	///@desc Skips to bottom of current editor 
	///@param {Real} _editor_index 
	///@param {Real} [_select = false]
	static texteditor_move_bottom = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_bottom());
	}
	__ImguiIg(texteditor_move_bottom)
	
	///@function texteditor_move_home(_editor_index, [_select = false])
	///@desc Moves to the home position of the current editor
	///@param {Real} _editor_index 
	///@param {Real} [_select = false]
	static texteditor_move_home = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_move_home());
	}
	__ImguiIg(texteditor_move_home)
	
	///@function texteditor_move_end(_editor_index, [_select = false])
	///@desc Moves to the end position of the current editor
	///@param {Real} _editor_index 
	///@param {Real} [_select = false]
	static texteditor_move_end = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		if (!__imguigml_ext_call(_extImguiGML_texteditor_move_end()))
			return;
	}
	__ImguiIg(texteditor_move_end)
	
	///@function texteditor_set_selection_start(_editor_index, _line, _col)
	///@desc Sets the start select position in the current editor
	///@param {Real} _editor_index 
	///@param {Real} _line
	///@param {Real} _col
	static texteditor_set_selection_start = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_set_selection_start());
	}
	__ImguiIg(texteditor_set_selection_start)
	
	///@function texteditor_set_selection_end(_editor_index, _line, _col)
	///@desc Sets the end select position in the current editor
	///@param {Real} _editor_index 
	///@param {Real} _line
	///@param {Real} _col
	static texteditor_set_selection_end = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_set_selection_end());
	}
	__ImguiIg(texteditor_set_selection_end)
	
	///@function texteditor_set_selection(_editor_index, _line1, _col1, _line2, _col2, [word_mode = false])
	///@desc Sets selection value in current editor
	///@param {Real} _editor_index 
	///@param {Real} _line1
	///@param {Real} _col1
	///@param {Real} _line2
	///@param {Real} _col2
	///@param {Boolean} [word_mode = false]
	static texteditor_set_selection = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		sr_buffer_write(in, argument_count > argi ? argument[argi] : false, ERousrData.Bool); argi++;
		__imguigml_ext_call(_extImguiGML_texteditor_set_selection());
	}
	__ImguiIg(texteditor_set_selection)
	
	///@function texteditor_select_word_under_cursor(_editor_index)
	///@desc Selects the word under the mouse cursor in the current editor
	///@param {Real} _editor_index 
	static texteditor_select_word_under_cursor = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_select_word_under_cursor());
	}
	__ImguiIg(texteditor_select_word_under_cursor)
	
	///@function texteditor_has_selection(_editor_index)
	///@desc Checks if current editor has selected text 
	///@param {Real} _editor_index 
	///@returns {Boolean}
	static texteditor_has_selection = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_has_selection()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(texteditor_has_selection)
	
	///@function texteditor_copy(_editor_index)
	///@desc Copies the selected tex
	///@param {Real} _editor_index
	static texteditor_copy = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_copy());
	}
	__ImguiIg(texteditor_copy)
	
	///@function texteditor_cut(_editor_index)
	///@desc Cuts the selected text
	///@param {Real} _editor_index 
	static texteditor_cut = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_cut());
	}
	__ImguiIg(texteditor_cut)
	
	///@function texteditor_paste(_editor_index)
	///@desc pastes the selected text
	///@param {Real} _editor_index 
	static texteditor_paste = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_paste());
	}
	__ImguiIg(texteditor_paste)
	
	///@function texteditor_delete(_editor_index)
	///@desc deletes the selected text
	///@param {Real} _editor_index 
	static texteditor_delete = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_texteditor_delete());
	}
	__ImguiIg(texteditor_delete)
	
	///@function texteditor_can_undo(_editor_index)
	///@desc Check if there is undo history
	///@param {Real} _editor_index 
	///@returns {Boolean}
	static texteditor_can_undo = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_can_undo()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(texteditor_can_undo)
	
	///@function texteditor_can_redo(_editor_index)
	///@desc Check if there is redo history
	///@param {Real} _editor_index 
	///@returns {Boolean}
	static texteditor_can_redo = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_can_redo()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(texteditor_can_redo)
	
	///@function texteditor_get_dark_palette(_editor_index)
	///@desc Gets the dark palette that may be used with editor 
	///@param {Real} _editor_index 
	///@returns {Array} 
	static texteditor_get_dark_palette = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_dark_palette()))
			return;
		var out = __Imgui_out;
		var palette = array_create(EImGuiText_Palette.Num, 0);
		var i = 0; repeat(EImGuiText_Palette.Num)
		  palette[@i++] = buffer_read(out, buffer_u8);
		return palette;
	}
	__ImguiIg(texteditor_get_dark_palette)
	
	///@function texteditor_get_light_palette(_editor_index)
	///@desc Gets the light palette that may be used with editor 
	///@param {Real} _editor_index 
	///@returns {Array} 
	static texteditor_get_light_palette = function(){
		var in = __Imgui_in, argi=0;
		sr_buffer_write(in, argument[argi++], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_texteditor_get_light_palette()))
			return;
		var out = __Imgui_out;
		var palette = array_create(EImGuiText_Palette.Num, 0);
		var i = 0; repeat(EImGuiText_Palette.Num)
		  palette[@i++] = buffer_read(out, buffer_u8);
		return palette;
	}
	__ImguiIg(texteditor_get_light_palette)
	
	#endregion
	#region tooltip functions
	
	///@function set_tooltip(_tooltip_text)
	///@desc set text tooltip under mouse-cursor, typically use with ImGui::IsItemHovered(). overidde any previous call to SetTooltip().
	///@param {String} _tooltip_text
	static set_tooltip = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, string(argument[0]));
		__imguigml_ext_call(_extImguiGML_set_tooltip());
	}
	__ImguiIg(set_tooltip)
	
	///@function begin_tooltip()
	///@desc begin/append a tooltip window. to create full-featured tooltip (with any kind of contents).
	static begin_tooltip = function(){
		__imguigml_ext_call(_extImguiGML_begin_tooltip());
	}
	__ImguiIg(begin_tooltip)
	
	///@function end_tooltip()
	///@desc end a tooltip window
	static end_tooltip = function(){
		__imguigml_ext_call(_extImguiGML_end_tooltip());
	}
	__ImguiIg(end_tooltip)
	
	#endregion
	#region utility functions
	
	///@function value(_label, _val_type, _val, [_float_format])
	///@desc Output single value in "name: value" format (tip: freely declare more in your code to handle your types. you can add functions to the ImGui namespace)
	///@param {String}              _prefix           value prefix
	///@param {Real:EImGui_ValType} _val_type         data type for value
	///@param {Real}                _val              value to apss
	///@param {String}              [_float_format]   (float value type only)
	static value = function(){
		var in = __Imgui_in;
	
		sr_buffer_write(in, string(argument[0]));                                   
		switch(argument[1]) {
		  case EImGui_ValType.Bool:        sr_buffer_write(in, argument[2] ? 1 : 0, ERousrData.Int8); break;
		  case EImGui_ValType.Int:         sr_buffer_write(in, argument[2], ERousrData.Int32); break;
		  case EImGui_ValType.UnsignedInt: sr_buffer_write(in, argument[2], ERousrData.Uint32); break;
		  case EImGui_ValType.Float:
		    sr_buffer_write(in, argument[2], ERousrData.Float); 
		    if (argument_count > 3) sr_buffer_write(in, string(argument[3]));
		  break;
		}
		__imguigml_ext_call(_extImguiGML_value());
	}
	__ImguiIg(value)
	
	///@function color_convert_u32_to_float4(_color)
	///@desc convert a u32 color to a float 4
	///@param {Real} _color   u32 color
	///@returns {Array:float4} _color
	static color_convert_u32_to_float4 = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Uint32);
		if (!__imguigml_ext_call(_extImguiGML_color_convert_u32_to_float4()))
			return;
		var out = __Imgui_out;
		var ret = array_create(4);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		ret[@ 2] = buffer_read(out, buffer_f32);
		ret[@ 3] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(color_convert_u32_to_float4)
	
	///@function color_convert_float4_to_u32(_r_or_array4, [_g=undefined], [_b=undefined], [_a=undefined])
	///@desc convert a float4 color to a u32
	///@param {Real} _r_or_array4
	///@param {Real} [_g=undefined]
	///@param {Real} [_b=undefined]
	///@param {Real} [_a=undefined]
	///@returns {Real} _color
	static color_convert_float4_to_u32 = function(){
		var in = __Imgui_in, argi=0;
	
		if(argument_count > 1){
			sr_buffer_write(in, argument[argi++], ERousrData.Float);
			sr_buffer_write(in, argument[argi++], ERousrData.Float);
			sr_buffer_write(in, argument[argi++], ERousrData.Float);
			sr_buffer_write(in, argument[argi++], ERousrData.Float);	
		}else{
			var _array = argument[0];
			sr_buffer_write(in, _array[argi++], ERousrData.Float);
			sr_buffer_write(in, _array[argi++], ERousrData.Float);
			sr_buffer_write(in, _array[argi++], ERousrData.Float);
			sr_buffer_write(in, _array[argi++], ERousrData.Float);
		}
	
		if (!__imguigml_ext_call(_extImguiGML_color_convert_float4_to_u32()))
			return;
		return buffer_read(__Imgui_out, buffer_u32);
	}
	__ImguiIg(color_convert_float4_to_u32)
	
	///@function color_convert_rgb_to_hsv(_r, _g, _b)
	///@desc convert rgb to hsv
	///@param {Real} _r
	///@param {Real} _g
	///@param {Real} _b
	///@returns {Array:[h,s,v]}
	static color_convert_rgb_to_hsv = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		sr_buffer_write(buff, argument[2], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_color_convert_rgb_to_hsv()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(3);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		ret[@ 2] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(color_convert_rgb_to_hsv)
	
	///@function color_convert_hsv_to_rgb(_h, _s, _v)
	///@desc convert rgb to hsv
	///@param {Real} _h
	///@param {Real} _s
	///@param {Real} _b
	///@returns {Array:[r,g,b]}
	static color_convert_hsv_to_rgb = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		sr_buffer_write(buff, argument[2], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_color_convert_hsv_to_rgb()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(3);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		ret[@ 2] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(color_convert_hsv_to_rgb)
	
	///@function is_item_hovered([_flags=0])
	///@desc is the last item hovered by mouse (and usable)?
	///@param {Real:EImGui_HoveredFlags} [_flags=0]
	///@returns {Boolean}
	static is_item_hovered = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_item_hovered()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_item_hovered)
	
	///@function is_item_active()
	///@desc is the last item active? (e.g. button being held, text field being edited- items that don't interact will always return false)
	///@returns {Boolean}
	static is_item_active = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_item_active()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_item_active)
	
	///@function is_item_clicked([_button=0])
	///@desc is the last item clicked? (e.g. button/node just clicked on)
	///@param {Real} [_button=0]   mouse_button
	///@returns {Boolean}
	static is_item_clicked = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_item_clicked()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_item_clicked)
	
	///@function is_item_visible()
	///@desc is the last item visible? (aka not out of sight due to clipping/scrolling.)
	///@returns {Boolean}
	static is_item_visible = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_item_visible()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_item_visible)
	
	///@function is_any_item_hovered()
	///@desc are any items hovered
	///@returns {Boolean}
	static is_any_item_hovered = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_any_item_hovered()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_any_item_hovered)
	
	///@function is_any_item_active()
	///@desc are any items active
	///@returns {Boolean}
	static is_any_item_active = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_any_item_active()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_any_item_active)
	
	///@function get_item_rect_min()
	///@desc get bounding rect of last item in screen space
	///@returns {Array:[x,y]}
	static get_item_rect_min = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_item_rect_min()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_item_rect_min)
	
	///@function get_item_rect_max()
	///@desc get bounding rect of last item in screen space
	///@returns {Array:[x,y]}
	static get_item_rect_max = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_item_rect_max()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_item_rect_max)
	
	///@function get_item_rect_size()
	///@desc get bounding rect of last item in screen space
	///@returns {Array:[x,y]}
	static get_item_rect_size = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_item_rect_size()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_item_rect_size)
	
	///@function set_item_allow_overlap
	///@desc allow last item to be overlapped by a subsequent item. sometimes useful with invisible buttons, selectables, etc. to catch unused area.
	static set_item_allow_overlap = function(){
		__imguigml_ext_call(_extImguiGML_set_item_allow_overlap());
	}
	__ImguiIg(set_item_allow_overlap)
	
	///@function is_window_focused([_flags=0])
	///@desc is current Begin()-ed window focused?
	///@param {Real:EImGui_FocusedFlags} [_flags=0]
	///@returns {Boolean}
	static is_window_focused = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0, ERousrData.Uint32);
		if (!__imguigml_ext_call(_extImguiGML_is_window_focused()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_window_focused)
	
	///@function is_window_hovered([_flags=0])
	///@desc is current Begin()-ed window hovered (and typically: not blocked by a popup/modal)?
	///@param {Real:EImGui_HoveredFlags} [_flags=0]
	///@returns {Boolean}
	static is_window_hovered = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_is_window_hovered()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_window_hovered)
	
	///@function is_rect_visible(_sizeOrMin, [_max])
	///@desc test if a rectangle is visible / not clipped
	///@param {Real} _size_or_min_x   if only size given, test from cursor pos
	///@param {Real} _size_or_min_y
	///@param {Real} [_max_x]         if max given, test in screen space
	///@param {Real} [_max_y]
	///@returns {Boolean}
	static is_rect_visible = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Float);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		if (argument_count > 2) {
		  sr_buffer_write(in, argument[2], ERousrData.Float);
		  sr_buffer_write(in, argument[3], ERousrData.Float);
		}
	
		if (!__imguigml_ext_call(_extImguiGML_is_rect_visible()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) != 0;
	}
	__ImguiIg(is_rect_visible)
	
	///@function get_time()
	///@desc get the time
	static get_time = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_time()))
			return;
		return buffer_read(__Imgui_out, buffer_f64);
	}
	__ImguiIg(get_time)
	
	///@function get_frame_count()
	///@desc get the time
	static get_frame_count = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_frame_count()))
			return;
		return buffer_read(__Imgui_out, buffer_s32);
	}
	__ImguiIg(get_frame_count)
	
	///@function get_style_color_name(_idx)
	///@desc get the style color's name
	///@param {Real:EImGui_Col} _idx
	///@returns {String} _color_name
	static get_style_color_name = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_get_style_color_name()))
			return;
		return buffer_read(__Imgui_out, buffer_string);
	}
	__ImguiIg(get_style_color_name)
	
	///@function calc_text_size(_text, [_text_end=undefined], [_hide_text_after_double_hash=false], [_wrap_width=-1.0f]);
	///@desc Calculate text size. Text can be multi-line. Optionally ignore text after a ## marker.
	///@param {String} _text
	///@param {String} [_text_end=undefined]
	///@param {Boolean} [_hide_text_after_double_hash=false]
	///@param {Real} [_wrap_width=-1.0f]);
	///@returns {Array:[x,y]}
	static calc_text_size = function(){
		var in = __Imgui_in;
	
		var _text_end = argument_count > 1 && is_string(argument[1]) ? argument[1] : noone;
		var _hide_text_after_double_hash = argument_count > 2 ? argument[2] : false;
	
		sr_buffer_write(in, string(argument[0]));
		sr_buffer_write(in, _text_end, !is_string(_text_end) ? ERousrData.Int8 : ERousrData.String);
		sr_buffer_write(in, _hide_text_after_double_hash ? 1 : 0, ERousrData.Int8);
		sr_buffer_write(in, argument_count > 3 ? argument[3] : -1.0, ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_calc_text_size()))
			return;
	
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(calc_text_size)
	
	///@function calc_list_clipping(_items_count, _items_height)
	///@desc calculate coarse clipping for large list of evenly sized items. Prefer using the ImGuiListClipper higher-level helper if you can.
	///@param {Real} _items_count
	///@param {Real} _items_height
	///@returns {Array:[item_start, item_end]}
	static calc_list_clipping = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Int32);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_calc_list_clipping()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_s32);
		ret[@ 1] = buffer_read(out, buffer_s32);
		return ret;
	}
	__ImguiIg(calc_list_clipping)
	
	///@function push_clip_rect(_min_x, _min_y, _max_x, _max_y, _intersect_with_current_clip_rect)
	///@desc
	///@param {Real}    _min_x                            clip_rect_min_x
	///@param {Real}    _min_y                            clip_rect_min_y
	///@param {Real}    _max_x                            clip_rect_max_x
	///@param {Real}    _max_y                            clip_rect_max_y
	///@param {Boolean} _intersect_with_current_clip_rect 
	static push_clip_rect = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Float);
		sr_buffer_write(in, argument[1], ERousrData.Float);
		sr_buffer_write(in, argument[2], ERousrData.Float);
		sr_buffer_write(in, argument[3], ERousrData.Float);
		sr_buffer_write(in, argument[4] ? 1 : 0, ERousrData.Int8);
		if (!__imguigml_ext_call(_extImguiGML_push_clip_rect()))
			return;
	}
	__ImguiIg(push_clip_rect)
	
	///@function pop_clip_rect
	///@desc pop the clip rect
	static pop_clip_rect = function(){
		if (!__imguigml_ext_call(_extImguiGML_pop_clip_rect()))
			return;
	}
	__ImguiIg(pop_clip_rect)
	
	#endregion
	#region window functions
	
	///@function start(_name, [_open=undefined], [_flags=0])
	///@desc Push a new ImGui window to add widgets to.
	///@param {String} _name                         title for window
	///@param {Real} [_open=undefined]               pass true/false for if this window is open w/close button, undefined for no button
	///@param {Real:EImGui_WindowFlags} [_flags=0]   window flags
	///@returns {Array:[_expanded, [_open]]}
	static start = function(){
		var in = __Imgui_in;
		var _name  = argument[0],
		    _open  = argument_count > 1 ? argument[1] : undefined,
		    _flags = argument_count > 2 ? argument[2] : 0;
	
		if (_open != undefined) _open = _open ? 1 : 0;
	
		sr_buffer_write(in, _name);
		sr_buffer_write(in, _open == undefined ? 0 : _open, _open == undefined ? ERousrData.Float : ERousrData.Int8);
		sr_buffer_write(in, _flags, ERousrData.Int32);
	
		if (!__imguigml_ext_call(_extImguiGML_begin()))
			return;
		var out = __Imgui_out;
		var ret = [ buffer_read(out, buffer_s8) != 0 ];
		if (_open != undefined)
		  ret[@ 1] = buffer_read(out, buffer_s8) != 0;
	
		return ret;
	}
	__ImguiIg(start)
	
	///@function finish()
	///@desc ImGui::End()
	static finish = function(){
		__imguigml_ext_call(_extImguiGML_end());
	}
	__ImguiIg(finish)
	
	///@function begin_child(_id, [_size_x=0], [_size_y=0], [_border=false], [_extra_flags=0])
	///@desc begin a scrolling region. each axis can use a different mode, e.g. ImVec2(0,400).
	///@param {Real|String} _id    
	///@param {Real}    [_size_x=0]    size==0.0f: use remaining window size, size<0.0f: use remaining window size minus abs(size). size>0.0f: fixed size. 
	///@param {Real}    [_size_y=0]    size==0.0f: use remaining window size, size<0.0f: use remaining window size minus abs(size). size>0.0f: fixed size. 
	///@param {Boolean} [_border=false]
	///@param {Real:EImGui_WindowFlags} [_extra_flags=0]
	///@returns {Boolean} false when collapsed
	static begin_child = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], is_string(argument[0]) ? ERousrData.String : ERousrData.Uint32);
		sr_buffer_write(in, argument_count > 1 ? argument[1] : 0, ERousrData.Float);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0, ERousrData.Float);
		sr_buffer_write(in, argument_count > 3 ? argument[3] : 0, ERousrData.Int8);
		sr_buffer_write(in, argument_count > 4 ? argument[4] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_begin_child()))
			return;
		var out = __Imgui_out;
		return buffer_read(out, buffer_s8) != 0;
	}
	__ImguiIg(begin_child)
	
	///@function end_child()
	///@desc end a scrolling region
	static end_child = function(){
		__imguigml_ext_call(_extImguiGML_end_child());
	}
	__ImguiIg(end_child)
	
	///@function get_content_region_max()
	///@desc current content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates
	///@returns {Array:EPos2D} boundaries
	static get_content_region_max = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_content_region_max()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_content_region_max)
	
	///@function get_content_region_avail
	///@desc == GetContentRegionMax() - GetCursorPos()
	///@returns {Array:EPos2D} region
	static get_content_region_avail = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_content_region_avail()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_content_region_avail)
	
	///@function get_content_region_avail_width
	///@desc get available width
	///@returns {Real} width
	static get_content_region_avail_width = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_content_region_avail_width()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_content_region_avail_width)
	
	///@function get_window_content_region_min
	///@desc content boundaries min (roughly (0,0)-Scroll), in window coordinates
	///@returns {Array:EPos2D} region
	static get_window_content_region_min = function(){
		//if (!__imguigml_ext_call(_extImguiGML_();
		if (!__imguigml_ext_call(_extImguiGML_get_window_content_region_min()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_window_content_region_min)
	
	///@function get_window_content_region_max
	///@desc content boundaries max (roughly (0,0)+Size-Scroll) where Size can be override with SetNextWindowContentSize(), in window coordinates
	///@returns {Array:EPos2D}
	static get_window_content_region_max = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_content_region_max()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_window_content_region_max)
	
	///@function get_window_content_region_width
	///@desc content width in windows coordinates
	///@returns {Real} content width
	static get_window_content_region_width = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_content_region_width()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_window_content_region_width)
	
	///@function get_window_pos
	///@desc get current window position in screen space (useful if you want to do your own drawing via the DrawList api)
	///@returns {Array:EPos2D} window pos
	static get_window_pos = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_pos()))
			return;
		
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_window_pos)
	
	///@function get_window_size
	///@desc get current window size
	///@returns {Array:E2D} size
	static get_window_size = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_size()))
			return;
		var out = __Imgui_out;
		var ret = array_create(2);
		ret[@ 0] = buffer_read(out, buffer_f32);
		ret[@ 1] = buffer_read(out, buffer_f32);
		return ret;
	}
	__ImguiIg(get_window_size)
	
	///@function get_window_width
	///@desc get current window width
	///@returns {Real} width
	static get_window_width = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_width()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_window_width)
	
	///@function get_window_height
	///@desc get current window height
	///@returns {Real} height
	static get_window_height = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_window_height()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_window_height)
	
	///@function is_window_collapsed()
	///@desc is current window collapsed
	///@returns {Boolean} is current window collapsed
	static is_window_collapsed = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_window_collapsed()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) == 1;
	}
	__ImguiIg(is_window_collapsed)
	
	///@function is_window_appearing()
	///@desc is current window appearing
	///@returns {Boolean} is current window appearing
	static is_window_appearing = function(){
		if (!__imguigml_ext_call(_extImguiGML_is_window_appearing()))
			return;
		return buffer_read(__Imgui_out, buffer_s8) == 1;
	}
	__ImguiIg(is_window_appearing)
	
	///@function set_window_font_scale(_scale)
	///@desc per-window font scale. Adjust IO.FontGlobalScale if you want to scale all windows
	///@param {Real} _scale   font scale for this window
	static set_window_font_scale = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_window_font_scale());
	}
	__ImguiIg(set_window_font_scale)
	
	///@function set_next_window_pos(_pos_x, _pos_y, [_cond=0], [_pivot_x=0], [_pivot_y=0])
	///@desc set next window position. call before Begin(). use pivot=(0.5f,0.5f) to center on given point, etc.
	///@param {Real}             _x          pos x
	///@param {Real}             _y          pos y
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	///@param {Real} [_pivot_x = 0]          used to center on a point
	///@param {Real} [_pivot_y = 0]          used to center on a point
	static set_next_window_pos = function(){
		var in = __Imgui_in;
		sr_buffer_write(in,                      argument[0],       ERousrData.Float);
		sr_buffer_write(in,                      argument[1],       ERousrData.Float);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0,   ERousrData.Int32);
		sr_buffer_write(in, argument_count > 4 ? argument[3] : 0.0, ERousrData.Float);
		sr_buffer_write(in, argument_count > 4 ? argument[4] : 0.0, ERousrData.Float);
	
		__imguigml_ext_call(_extImguiGML_set_next_window_pos());
	}
	__ImguiIg(set_next_window_pos)
	
	///@function set_next_window_size(_size_x, _size_y, [_cond=0])
	///@desc set next window size. set axis to 0.0f to force an auto-fit on this axis. call before Begin()
	///@param {Real}             _x          size x
	///@param {Real}             _y          size y
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_next_window_size = function(){
		var in = __Imgui_in;
		sr_buffer_write(in,                      argument[0],       ERousrData.Float);
		sr_buffer_write(in,                      argument[1],       ERousrData.Float);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0,   ERousrData.Int32);
	
		__imguigml_ext_call(_extImguiGML_set_next_window_size());
	}
	__ImguiIg(set_next_window_size)
	
	///@function set_next_window_size_constraints(_min_size_x, _min_size_y, _max_size_x, _max_size_y)
	///@desc set next window size limits. use -1,-1 on either X/Y axis to preserve the current size. 
	///@param {Real}             _min_x      min size x
	///@param {Real}             _min_y      min size y
	///@param {Real}             _max_x      max size x
	///@param {Real}             _max_y      max size y
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_next_window_size_constraints = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		sr_buffer_write(buff, argument[2], ERousrData.Float);
		sr_buffer_write(buff, argument[3], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_next_window_size_constraints());
	}
	__ImguiIg(set_next_window_size_constraints)
	
	///@function set_next_window_content_size(_size_x, _size_y)
	///@desc set next window content size (enforce the range of scrollbars). set axis to 0.0f to leave it automatic. call before Begin()
	///@param {Real} _size_x   width
	///@param {Real} _size_y   height
	static set_next_window_content_size = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument[1], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_next_window_content_size());
	}
	__ImguiIg(set_next_window_content_size)
	
	///@function set_next_window_collapsed(_collapsed, [_cond=0])
	///@desc set next window collapsed state. call before Begin()
	///@param {Boolean} _collapsed           true if collapsed
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_next_window_collapsed = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0] ? 1 : 0, ERousrData.Int8);
		sr_buffer_write(buff, argument_count > 1 ? argument[1] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_set_next_window_collapsed());
	}
	__ImguiIg(set_next_window_collapsed)
	
	///@function set_next_window_focus()
	///@desc set next window to be focused / front-most. call before Begin()
	static set_next_window_focus = function(){
		if (!__imguigml_ext_call(_extImguiGML_set_next_window_focus()))
			return;
	}
	__ImguiIg(set_next_window_focus)
	
	///@function set_window_pos(_name, _pos_x, _pos_y, [_cond=0])
	///@desc set named window position.
	///@param {String} _name                 name
	///@param {Real}   _pos_x          pos x
	///@param {Real}   _pos_y          pos y
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_window_pos = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff,                      argument[0]);
		sr_buffer_write(buff,                      argument[1],     ERousrData.Float);
		sr_buffer_write(buff,                      argument[2],     ERousrData.Float);
		sr_buffer_write(buff, argument_count > 3 ? argument[3] : 0, ERousrData.Int32);
		if (!__imguigml_ext_call(_extImguiGML_set_window_pos()))
			return;
	}
	__ImguiIg(set_window_pos)
	
	///@function set_window_size(_name, _size_x, _size_y, [_cond=0])
	///@desc  set named window size. set axis to 0.0f to force an auto-fit on this axis.
	///@param {String} _name                 name
	///@param {Real}   _size_x               size x
	///@param {Real}   _size_y               size y
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_window_size = function(){
		var in = __Imgui_in;
		sr_buffer_write(in,                      argument[0]);
		sr_buffer_write(in,                      argument[1],     ERousrData.Float);
		sr_buffer_write(in,                      argument[2],     ERousrData.Float);
		sr_buffer_write(in, argument_count > 3 ? argument[3] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_set_window_size());
	}
	__ImguiIg(set_window_size)
	
	///@function set_window_collapsed(_name, _collapsed, [_cond=0])
	///@desc set named window collapsed state
	///@param {String} _name                 name
	///@param {Boolean} _collapsed           true if collapsed
	///@param {Real:EImGui_Cond} [_cond=0]   condition for setting (not a bit flag)
	static set_window_collapsed = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0]);
		sr_buffer_write(in, argument[1] ? 1 : 0, ERousrData.Int8);
		sr_buffer_write(in, argument_count > 2 ? argument[2] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_set_window_collapsed());
	}
	__ImguiIg(set_window_collapsed)
	
	///@function set_window_focus(_name)
	///@desc set named window to be focused / front-most. use NULL to remove focus.
	///@param {String} _name   named window
	static set_window_focus = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, string(argument[0]));
		__imguigml_ext_call(_extImguiGML_set_window_focus());
	}
	__ImguiIg(set_window_focus)
	
	///@function get_scroll_x()
	///@desc get scrolling amount [0..GetScrollMaxX()]
	///@returns {Real} [0..GetScrollMaxX()]
	static get_scroll_x = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_scroll_x()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_scroll_x)
	
	///@function get_scroll_y()
	///@desc get scrolling amount [0..GetScrollMaxY()]
	///@returns {Real} [0..GetScrollMaxY()]
	static get_scroll_y = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_scroll_y()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_scroll_y)
	
	///@function get_scroll_max_x()
	///@desc get maximum scrolling amount ~~ ContentSize.X - WindowSize.X
	///@returns {Real} scrolling amount ~~ ContentSize.X - WindowSize.X
	static get_scroll_max_x = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_scroll_max_x()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_scroll_max_x)
	
	///@function get_scroll_max_y()
	///@desc get maximum scrolling amount ~~ ContentSize.Y - WindowSize.Y
	///@returns {Real} scrolling amount ~~ ContentSize.Y - WindowSize.Y
	static get_scroll_max_y = function(){
		if (!__imguigml_ext_call(_extImguiGML_get_scroll_max_y()))
			return;
		return buffer_read(__Imgui_out, buffer_f32);
	}
	__ImguiIg(get_scroll_max_y)
	
	///@function set_scroll_x(_scroll_x)
	///@desc set scrolling amount [0..GetScrollMaxX()]
	///@param {Real} _scroll_x   0..GetScrollMaxX()
	static set_scroll_x = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_scroll_x());
	}
	__ImguiIg(set_scroll_x)
	
	///@function set_scroll_y(_scroll_y)
	///@desc set scrolling amount [0..GetScrollMaxY()]
	///@param {Real} _scroll_y   0..GetScrollMaxY()
	static set_scroll_y = function(){
		var in = __Imgui_in;
		sr_buffer_write(in, argument[0], ERousrData.Float);
		if (!__imguigml_ext_call(_extImguiGML_set_scroll_y()))
			return;
	}
	__ImguiIg(set_scroll_y)
	
	///@function set_scroll_here_x()
	///@desc  adjust scrolling amount to make current cursor position visible. 
	static set_scroll_here_x = function(){
		if (!__imguigml_ext_call(_extImguiGML_set_scroll_here_x()))
			return;
	}
	__ImguiIg(set_scroll_here_x)
	
	///@function set_scroll_here_y()
	///@desc  adjust scrolling amount to make current cursor position visible. 
	static set_scroll_here_y = function(){
		if (!__imguigml_ext_call(_extImguiGML_set_scroll_here_y()))
			return;
	}
	__ImguiIg(set_scroll_here_y)
	
	///@function set_scroll_from_pos_y(_pos_y, [_center_y_ratio=0.5])
	///@desc adjust scrolling amount to make given position valid. use GetCursorPos() or GetCursorStartPos()+offset to get valid positions.
	///@param {Real} [_center_y_ratio=0.0]  top, 0.5: center, 1.0: bottom.
	static set_scroll_from_pos_y = function(){
		var buff = __imguigml_wrapper_buffer()
		sr_buffer_write(buff, argument[0], ERousrData.Float);
		sr_buffer_write(buff, argument_count > 1 ? argument[1] : 0.0, ERousrData.Float);
		__imguigml_ext_call(_extImguiGML_set_scroll_from_pos_y());
	}
	__ImguiIg(set_scroll_from_pos_y)
	
	///@function set_keyboard_focus_here([_offset=0])
	///@desc focus keyboard on the next widget. 
	///@param {Real} [_offset]   Use positive 'offset' to access sub components of a multiple component widget. Use -1 to access previous widget.
	static set_keyboard_focus_here = function(){
		sr_buffer_write(__Imgui_in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_set_keyboard_focus_here());
	}
	__ImguiIg(set_keyboard_focus_here)
	
	///@function set_state_storage(_tree)
	///@desc replace tree state storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
	///@param {*} _tree   todo: implement
	static set_state_storage = function(){
		//var buff = __imguigml_wrapper_buffer()
		//sr_buffer_write(buff, <something>, <something);
		//if (!__imguigml_ext_call(_extImguiGML_set_state_storage();
	
		// todo: implement
	}
	__ImguiIg(set_state_storage)
	
	///@function get_state_storage(_tree)
	///@desc replace tree state storage with our own (if you want to manipulate it yourself, typically clear subsection of it)
	///@param {*} _tree   todo: implement
	static get_state_storage = function(){
	
		//if (!__imguigml_ext_call(_extImguiGML_get_state_storage();
		//var buff = __imguigml_wrapper_buffer()
	
		// todo: implement
	}
	__ImguiIg(get_state_storage)
	
	///@function begin_child_frame(_guiID, [_size_x], [_size_y], [_extra_flags=0])
	///@desc helper to create a child window / scrolling region that looks like a normal widget frame
	///@param {Real}                    _guiID             ImGui ID
	///@param {Real}                    _size_x            width
	///@param {Real}                    _size_y            height
	///@param {Real:EImGui_WindowFlags} [_extra_flags=0]   
	static begin_child_frame = function(){
		sr_buffer_write(__Imgui_in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_begin_child_frame());
	}
	__ImguiIg(begin_child_frame)
	
	///@function end_child_frame()
	///@desc helper to create a child window / scrolling region that looks like a normal widget frame
	///@param {Real} [_offset]   Use positive 'offset' to access sub components of a multiple component widget. Use -1 to access previous widget.
	static end_child_frame = function(){
		sr_buffer_write(__Imgui_in, argument_count > 0 ? argument[0] : 0, ERousrData.Int32);
		__imguigml_ext_call(_extImguiGML_set_keyboard_focus_here());
	}
	__ImguiIg(end_child_frame)
	
	///@function show_metrics_window([_open=undefined])
	///@desc create metrics window. display ImGui internals: draw commands (with individual draw calls and vertices), window list, basic internal state, etc.
	///@param {Bool} [_open=undefined]   if passed, gives the window a close button
	///@returns {Array:[_expanded, [_open]]} (always expanded)
	static show_metrics_window = function(){
		var in = __Imgui_in;
		var _open  = argument_count > 0 ? argument[0] : undefined;
	
		if (_open != undefined) _open = _open ? 1 : 0;
		sr_buffer_write(in, _open == undefined ? 0 : _open, _open == undefined ? ERousrData.Float : ERousrData.Int8);
	
		if (!__imguigml_ext_call(_extImguiGML_show_metrics_window()))
			return;
		var out = __Imgui_out;
		var ret = [ 1 ];
		if (_open != undefined)
		  ret[@ 1] = buffer_read(out, buffer_s8) != 0;
	
		return ret;
	}
	__ImguiIg(show_metrics_window)
	
	///@function show_user_guide()
	///@desc add basic help/info block (not a window): how to manipulate ImGui as a end-user (mouse/keyboard controls).
	static show_user_guide = function(){
		__imguigml_ext_call(_extImguiGML_show_user_guide());
	}
	__ImguiIg(show_user_guide)
	
	///@function show_demo_window([_open=undefined])
	///@desc create demo/test window (previously called ShowTestWindow). demonstrate most ImGui features. call this to learn about the library! try to make it always available in your application!
	///@param {Bool} [_open=undefined]   if passed, gives the window a close button
	///@returns {Array:[_expanded, [_open]]} (always expanded)
	static show_demo_window = function(){
		var in = __Imgui_in;
		var _open  = argument_count > 0 ? argument[0] : undefined;
	
		if (_open != undefined) _open = _open ? 1 : 0;
		sr_buffer_write(in, _open == undefined ? 0 : _open, _open == undefined ? ERousrData.Float : ERousrData.Int8);
	
		if (!__imguigml_ext_call(_extImguiGML_show_demo_window()))
			return;
		var out = __Imgui_out;
		var ret = [ 1 ];
		if (_open != undefined)
		  ret[@ 1] = buffer_read(out, buffer_s8) != 0;
	
		return ret;
	}
	__ImguiIg(show_demo_window)
	
	///@function show_font_selector(_label)
	///@desc show a font selector **NOTE:** Functionality is limited at this time until `ImGuiGML` has better font support
	///@param {String} _label
	static show_font_selector = function(){
		var _label = argument[0];
		var in = __Imgui_in;
		sr_buffer_write(in, _label, ERousrData.String);
		__imguigml_ext_call(_extImguiGML_show_font_selector());
	}
	__ImguiIg(show_font_selector)
	
	#endregion

}