function node_editor(node){
	if (node == pointer_null) return;
	
	var width = 250;
	var height = 300;
	var padding = 10;
	
	var tx = display_get_gui_width() - padding - width;
	var ty = headerSize[1] + padding;
	
	window("Node", "nodeEditor", function() {
		var node = controller.selected.node;

		push_item_width(-1);
		begin_group();
			text("name");
			same_line(50);
			push_item_width(-1);
			node.name = textbox(node.name, "nodeName");
			pop_item_width();
		end_group()
		
		if (controller.skeleton.root != node){
			begin_group();
				node.connected = checkbox("Connected ### boneConnected", node.connected)[1];
			end_group()
		}
		
		paragraph("Positions");
		
		begin_group();
			text("x");
			same_line(50);
			push_item_width(-1);
			node.x = int_input("x", "nodeX", node.x, 1, 1);
			pop_item_width();
		end_group()
		
		begin_group();
			text("y");
			same_line(50);
			push_item_width(-1);
			node.y = int_input("y", "nodeY", node.y, 1, 1);
			pop_item_width();
		end_group()
		
		begin_group();
			text("depth");
			same_line(50);
			push_item_width(-1);
			node.depth = int_input("depth", "nodeDepth", node.depth, 1, 1);
			pop_item_width();
		end_group()
		
		if (controller.skeleton.root == node) return;

		paragraph("Bone");

		if (sprite_button(sBone, 0, 64, 64, 0)) {
			open_popup("query");
			search.type = "sprite";
			search.content = spriteList;
		}
		
		same_line();
		begin_group();
			text("Bone sprite");
			text(node.bone.sprite == pointer_null ? "No sprite selected" : node.bone.sprite.name);
		end_group();
		
		begin_group();
			node.bone.lockLength = checkbox("Lock length ### boneLockLength", node.bone.lockLength)[1];
			same_line();
			
			sprite(sTooltip, 0, 16, 16);
			if (is_item_hovered()){
				begin_tooltip();
					text("lock the bone's length to the sprite rig's length")
				end_tooltip();
			}
		end_group();
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