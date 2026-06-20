function EditorInterface(controller) constructor {
	self.controller = controller;
	
	gui = new UI();
	destroy = gui.destroy;
	
	headerDimensions = [0, 0];
	navbar = [0, 0];
	focus = false
	
	search = {
		sprite: false,	
	}
	
	step = function(){
		focus = false;
		gui.step();

		if (gui.ready()) { 

			header();
			if (controller.selected.node != pointer_null) node_edit();
			if (search.sprite) sprite_query();
		}
		
		return (imguigml_is_any_item_active() or imguigml_is_any_item_hovered() or imguigml_is_window_hovered(EImGui_FocusedFlags.AnyWindow));
	}
	
	sprite_query = function() {
		var w = 400;
		var h = 300;
		var tx = display_get_gui_width() / 2 - w / 2;
		var ty = display_get_gui_height() / 2 - h / 2;
		
		imguigml_set_next_window_pos(tx, ty, EImGui_Cond.Always);
		imguigml_set_next_window_size(w, h, EImGui_Cond.Always);
		
		var flags = EImGui_WindowFlags.NoMove | EImGui_WindowFlags.NoResize | EImGui_WindowFlags.NoCollapse;
		var ret = imguigml_begin("Search", search.sprite, flags);
		search.sprite = ret[1] and (imguigml_is_window_focused(EImGui_FocusedFlags.ChildWindows) or imguigml_is_window_hovered(EImGui_HoveredFlags.ChildWindows));
		
		gui.input_text("search sprite", "spriteSearch", 1000, function(){
		    
		});
		
		var btn_label = "load image";
		var btn_width = 100;
		
		var avail = imguigml_get_content_region_avail();
		var target_x = avail[0] - btn_width;
		imguigml_set_cursor_pos_x(target_x);
		gui.button(btn_label, "loadSprite", function(){
			
		}, btn_width);
		
		imguigml_separator(); // optional, just visually separates the fixed header from the scroll area
		
		// everything below this point scrolls; the input above never moves
		if (imguigml_begin_child("search_results", -1, -1, false)) {
		    repeat(10) gui.image_button_with_text("something", sBone, 0, "top text", "bottom text", 64);
		}
		imguigml_end_child(); // ALWAYS call, same Begin/End pairing rule as windows
		
		imguigml_end()
	}
	
	sprite_button = function(sprite){
		var tex = sprite_get_texture(sprite, 0);
		var uv = sprite_get_uvs(sprite, 0);
		
		imguigml_button("", -1, 64);
	}
	
	grid_settings = function(){
		var label_col_width = 100
		
		gui.label("size ");
		gui.same_line();
		imguigml_set_cursor_pos_x(label_col_width);
		gui.input_int("", "gridSizeInt", [controller.grid.size], 1, 1, function(val){
			controller.grid.size = val;
			controller.grid.build();
		});
		
		gui.separator();
		
		gui.label("line color");
		gui.same_line();
		imguigml_set_cursor_pos_x(label_col_width);
		gui.color_edit("", "gridLineColorEdit", controller.grid.line,
		    function(color) {
		        controller.grid.line = color;
		        controller.grid.build();
		    }
		);
		
		gui.label("origin color");
		gui.same_line();
		imguigml_set_cursor_pos_x(label_col_width);
		gui.color_edit("", "gridOriginColorEdit", controller.grid.origin,
		    function(color) {
		        controller.grid.origin = color;
		        controller.grid.build();
		    }
		);
		
		
	}
	
	header = function(){
		gui.menu_main(function(){
			gui.menu_strip("File", "menuFile", function(){
				gui.menu_item("Open", "fileOpen", -1);
				gui.menu_item("Save", "fileSave", -1);
				gui.menu_item("Export", "fileExport", -1);
				
				gui.separator();
				gui.menu_item("AddSprite", "fileAddSprite", -1);
			});
			
			gui.menu_strip("Edit", "menuEdit", function(){
				gui.menu_strip("Grid", "gridEdit", grid_settings);
			})
			
			gui.menu_strip("Help", "menuHelp", function(){
			
			});
			
			headerDimensions = imguigml_get_window_size();
		});
		
		var flags = EImGui_WindowFlags.NoDecoration
		
		var tx = display_get_gui_width() / 2 - navbar[0] / 2;
		var ty = headerDimensions[1];
		imguigml_set_next_window_pos(tx, ty, EImGui_Cond.Always);
		
		imguigml_begin("", true, flags)
			var w = 200;
			var h = 24;
			
			imguigml_button("1. Create a rig", w, h);
			gui.same_line();
			imguigml_button("2. Edit sprite rig", w, h);
			gui.same_line();

			imguigml_button("3. Animate", w, h);
			
			navbar = imguigml_get_window_size();
		imguigml_end();
	}
	
	node_edit = function(){
		gui.window("Node", "NodeEdit", display_get_gui_width() - 10 - 200, headerDimensions[1] + 10, 200, 300, function(){
			var node = controller.selected.node;
			gui.label("name")
			gui.same_line()
			gui.input_text("", "testInput", node.name, 100, function(_text){
				controller.selected.node.name = _text	
			});
			
			gui.checkbox("connected", "nodeConnected", node.connected, function(value){
				controller.selected.node.connected = value;
			});
			
			
			gui.paragraph("Positions");

			gui.input_float("x", "nodeX", [node.x], 1, 10, function(value){
				controller.selected.node.x = value
			});
			
			gui.input_float("y", "nodeY", [node.y], 1, 10, function(value){
				controller.selected.node.y = value
			});
			
			gui.input_float("depth", "nodeDepth", [node.depth], 1, 10, function(value){
				controller.selected.node.depth = value
			});
			
			
			gui.paragraph("Bone");
			
			var tex = sprite_get_texture(sBone, 0);
			var uv = sprite_get_uvs(sBone, 0);
			
			if (imguigml_image_button(tex, 64, 64, uv[0], uv[1], uv[2], uv[3])) search.sprite = true;
			
			gui.checkbox("lock length", "lockBoneLength", node.bone.lockLength, function(value){
				controller.selected.node.bone.lockLength = value;
			});
			
			gui.same_line();

			gui.tooltip("whether to lock the bone's length to the sprite's rig length");
});
	}

	draw = function(){
		gui.render();
	}
}