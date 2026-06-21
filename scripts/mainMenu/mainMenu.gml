function mainMenu(){
	return main_menu(function(){
		menu_strip("file", "mnuFile",mainMenuFile);
		menu_strip("edit", "mnuEdit", mainMenuEdit);
	});
}