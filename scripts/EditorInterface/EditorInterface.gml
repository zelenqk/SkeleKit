function EditorInterface(controller) : imGuiPrefabs() constructor {
	self.controller = controller;
	
	step = function(){
		if (!update()) return;
		
		headerSize = mainMenu();
		
		node_editor(controller.selected.node);
		
		return (is_any_item_active() or is_window_hovered(EImGui_HoveredFlags.AnyWindow));
	}
	
	draw = function(){
		render();
	}
}
