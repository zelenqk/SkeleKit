function EditorInterface(controller) constructor {
	self.controller = controller;
	
	gui = new UI();
	
	destroy = gui.destroy;
	
	step = function(){
		gui.step();

		if (gui.ready()) { 
			header();
			
			node_edit();
		}
		
		return imguigml_is_any_item_active();
	}
	
	grid_settings = function(){
		gui.push_item_width(200);
		gui.label("size ");
		gui.same_line();
		gui.push_item_width(100);
		gui.input_int("", "gridSizeInt", [controller.grid.size], 1, 1, function(val){
			controller.grid.size = val;
			controller.grid.build();
		});
		
		gui.separator();
		
		gui.push_item_width(200);
		gui.label("line color");
		gui.same_line();
		gui.color_edit("", "gridLineColorEdit", controller.grid.line,
		    function(color) {
		        controller.grid.line = color;
		        controller.grid.build();
		    }
		);
		
		gui.push_item_width(200);
		gui.label("origin color");
		gui.same_line();
		gui.color_edit("", "gridOriginColorEdit", controller.grid.origin,
		    function(color) {
		        controller.grid.origin = color;
		        controller.grid.build();
		    }
		)
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
		});	
	}
	
	node_edit = function(){
		gui.window("Node", "NodeEdit", display_get_gui_width() - 10 - 200, 30, 200, 300, function(){
			var node = controller.selected.node;
			gui.label("name")
			gui.same_line()
			gui.input_text("", "testInput", node.name, 100, function(_text){
				controller.selected.node.name = _text	
			});
			
			gui.checkbox("fixed", "nodeFixed", node.fixed, function(value){
				controller.selected.node.fixed = value;
			});
			
			gui.checkbox("connected", "nodeConnected", node.connected, function(value){
				controller.selected.node.connected = value;
			});
			
			gui.separator();
			
			gui.label("positions");
			
			gui.input_float("x", "nodeX", [node.x], 1, 10, function(value){
				controller.selected.node.x = value
			});
			
			gui.input_float("y", "nodeY", [node.y], 1, 10, function(value){
				controller.selected.node.y = value
			});
			
			gui.input_float("depth", "nodeDepth", [node.depth], 1, 10, function(value){
				controller.selected.node.depth = value
			});
		});
	}

	draw = function(){
		gui.render();
	}
}