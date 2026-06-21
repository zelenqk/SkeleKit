function mainMenu(){
	main_menu(function(){
		menu_strip("file", "mnuFile", function(){
			text("test");
		});
		
		menu_strip("edit", "mnuEdit", mainMenuEdit);
	});
}