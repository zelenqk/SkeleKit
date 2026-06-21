function EditorInterface(controller) : imGuiPrefabs() constructor {
	self.controller = controller;
	
	step = function(){
		if (!update()) return;
		
		mainMenu();
		
		return (is_any_item_active() or is_window_focused(EImGui_FocusedFlags.AnyWindow) or is_window_hovered(EImGui_HoveredFlags.AnyWindow));
	}
	
	draw = function(){
		render();
	}
}
