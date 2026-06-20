function EditorInterface(controller) constructor {
	self.controller = controller;
	
	gui = new UI();
	destroy = gui.destroy;
	
	headerDimensions = [0, 0];
	
	step = function(){
		gui.step();

		if (gui.ready()) { 

			header();
			if (controller.selected.node != pointer_null) node_edit();
		}
		
		return imguigml_is_any_item_active();
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
			
			headerDimensions = imguigml_get_item_rect_max();
		});	
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
			
			imguigml_image_button(tex, 64, 64, uv[0], uv[1], uv[2], uv[3]);
			
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