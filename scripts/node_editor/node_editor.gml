function node_editor(node){
	if (node == pointer_null) return;
	
	var width = 250;
	var height = 300;
	var padding = 10;
	
	var tx = display_get_gui_width() - padding - width;
	var ty = headerSize[1] + padding;
	
	window("Node", "nodeEditor", function() {
		push_item_width(-1);
		begin_group();
			var node = controller.selected.node;
			text("name");
			same_line(50);
			push_item_width(-1);
			node.name = textbox(node.name, "nodeName");
			pop_item_width();
		end_group()
		
		paragraph("Positions");
		
		begin_group();
			var node = controller.selected.node;
			text("x");
			same_line(50);
			push_item_width(-1);
			node.x = int_input("x", "nodeX", node.x, 1, 1);
			pop_item_width();
		end_group()
		
		begin_group();
			var node = controller.selected.node;
			text("y");
			same_line(50);
			push_item_width(-1);
			node.y = int_input("y", "nodeY", node.y, 1, 1);
			pop_item_width();
		end_group()
		
		begin_group();
			var node = controller.selected.node;
			text("depth");
			same_line(50);
			push_item_width(-1);
			node.depth = int_input("depth", "nodeDepth", node.depth, 1, 1);
			pop_item_width();
		end_group()
		
		paragraph("Bone");
		
	}, 
		//dimensions
		tx, ty, 
		width, height, 
		//flags
		EImGui_WindowFlags.NoMove | EImGui_WindowFlags.NoResize | 
		EImGui_WindowFlags.NoCollapse,
		//first time update only
		false
	);
}