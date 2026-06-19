if (interface.step()) exit;

if (mouse_check_button_pressed(mb_left)) {
	end_interaction();
	selected.node = skeleton.root;
	
	for(var i = 0; i < array_length(skeleton.nodes); i++) {
		var node = skeleton.nodes[i];
		
		if (point_in_circle(camera.mouse.x, camera.mouse.y, node.x, node.y, 16)) {
			selected.node = node;
			break;
		}
	}
}

switch (selected.interaction){
case INTERACT.MOVE:
	var tx = camera.mouse.x;
	var ty = camera.mouse.y;
	
	if (bind.snap) {
		var snapped = grid.snap(tx, ty);
		tx = snapped.x;
		ty = snapped.y;
	}
	
	var node = selected.node;
	
	node.x = tx;
	node.y = ty;
	
	node.bone.length = point_distance(node.parent.x, node.parent.y, tx, ty);
	node.bone.direction = point_direction(node.parent.x, node.parent.y, tx, ty);
	
	for(var i = 0; i < array_length(node.children); i++) {
		var n = node.children[i];
		n.bone.length = point_distance(tx, ty, n.x, n.y);
		n.bone.direction = point_direction(tx, ty, n.x, n.y);
	}
	break;
}

if (bind.extrude) skeleton.add(camera.mouse.x, camera.mouse.y, -1, selected.node);
if (bind.move) {
	var node = selected.node;
	selected.state = capture_node_state(node);
	
	selected.interaction = (selected.interaction == INTERACT.MOVE) ? pointer_null : INTERACT.MOVE;
}