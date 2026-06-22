function EditorInterface(controller) : imGuiPrefabs() constructor {
	self.controller = controller;
	
	search = {
		type: pointer_null,
		query: "",
		content: [],
	};
	
	addSprite = function() {
		var path = get_open_filename_cross_platform("image", "");
		if (path == "" or path == undefined) return;
		
		controller.selected.node.bone.sprite = new Sprite(path);
	}
	
	step = function(){
		if (!update()) return;
		
		headerSize = mainMenu();
		
		node_editor(controller.selected.node);
		
		if (search.type != pointer_null) {
			var res = search_window("search " + search.type, search.query, array_query_fuzzy_sort(search.content, search.query), function(_sprite) {
				var index = _sprite.index;
				var start_screen_pos = get_cursor_screen_pos();
				
				var clicked = invisible_button(string(index), -1, 48);
				
				set_cursor_screen_pos(start_screen_pos[0], start_screen_pos[1]); // jump back to draw real content ON TOP of the invisible button
				
				begin_group();
				    sprite(index, 0, 48, 48);
				    same_line();
				
				    begin_group();
						set_window_font_scale(2);
							text(_sprite.name);
						set_window_font_scale(1);
						push_style_color(EImGui_Col.Text, $4fFFFFFF); // red text
				        text(_sprite.path);
						pop_style_color(1);
					end_group();
				end_group();
			}, (search.type == "sprite") ? {
				label: "add sprite",
				onClick: addSprite,
				
			} : undefined);
			
			search.query = res[0];
			
			if (!res[1]) {
				search.type = pointer_null;	
				search.query = "";
			}
		}
		
		return (is_any_item_active() or is_window_hovered(EImGui_HoveredFlags.AnyWindow));
	}
	
	draw = function(){
		render();
	}
}
