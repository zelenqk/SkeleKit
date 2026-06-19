function EditorInterface(controller) constructor {
	self.controller = controller;
	
	gui = new UI();
	gui.init();
	
	step = function(){
		gui.step();

		if (gui.ready()) { 
			header();
			
			node_edit();
		}
		
		return imguigml_is_any_item_active();
	}

	header = function(){
		gui.menu_main(function(){
			gui.menu_strip("File", "mnuFile", function(){
				gui.menu_item("Open", "fileOpen", -1);
				gui.menu_item("Save", "fileSave", -1);
				gui.menu_item("Export", "fileExport", -1);
				
				gui.separator();
				gui.menu_item("AddSprite", "fileAddSprite", -1);
			});
			
			gui.menu_strip("Edit", "mnuEdit", function(){
			
			});
			
			gui.menu_strip("Help", "mnuHelp", function(){
			
			});
		});	
	}
	
	node_edit = function(){
		gui.window("Node", "NodeEdit", display_get_gui_width() - 10 - 200, 30, 200, 300, function(){
			var node = controller.selected.node;
			gui.input_text("name", "testInput", node.name, 100, function(_text){
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