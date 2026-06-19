
//systems
interface = new EditorInterface(self);
action = new ActionControl();

key = new Keybinds();
bind = key.environment;

grid = new Grid();
grid.set_size(32, 128);

camera = new Camera();
camera.setup();

skeleton = new Skeleton();

//setup
key.bind("extrude", "e", false, KEY.PRESS);
key.bind("move", "g", false, KEY.PRESS);
key.bind("snap", vk_control, false, KEY.HOLD);
key.bind("undo", [vk_control, "z"], true, KEY.HOLD);
key.bind("redo", [vk_control, "y"], true, KEY.HOLD);

//cache
read_config();
dimensions = {width: window_get_width(), height: window_get_height()}

enum MODE { CREATE_RIG, RIG_SPRITE, ANIMATE };
enum INTERACT { MOVE };

doindex = 0;
dolist = [];

selected = {
	node: skeleton.root,	
	bone: pointer_null,
	mode: MODE.CREATE_RIG,
	
	interaction: pointer_null,
}

end_interaction = function(){
	switch (selected.interaction){
	case INTERACT.MOVE:
		action.add(selected.state, capture_node_state(selected.node), move_node);	
		break;
	}
	
	selected.interaction = pointer_null;
}

