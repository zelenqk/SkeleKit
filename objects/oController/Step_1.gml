if (dimensions.width != window_get_width() or dimensions.height != window_get_height()){
	dimensions.width = window_get_width();
	dimensions.height = window_get_height();
	
	camera.resize(dimensions.width, dimensions.height)	
}

key.step();

if (bind.undo) action.undo();
if (bind.redo) action.redo();