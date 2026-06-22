function mainMenuEdit(){
	mainMenuEditGrid();
}


function mainMenuEditGrid() {
	menu_strip("Grid", "edtGrid", function(){
		begin_group();
			controller.grid.enabled = checkbox("enabled", controller.grid.enabled)[1];
		end_group();
		
		begin_group();
			text("size");
			same_line(100, -1);
			controller.grid.size = int_input("", "edtGrdSiz", controller.grid.size, 1, 1, controller.grid.build);
		end_group();
		
		separator();
		
		begin_group();
			text("line color");
			same_line(100, -1);
			controller.grid.line = color_editor("", "edtGrdLin", controller.grid.line, controller.grid.build);
		end_group();
		
		begin_group();
			text("origin color");
			same_line(100, -1);
			controller.grid.origin = color_editor("", "edtGrdOrg", controller.grid.origin, controller.grid.build);
		end_group();
		
	})	
}