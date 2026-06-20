globalvar skeleton_debug_pallette;
skeleton_debug_pallette = {
	node: #4A9EFF,
	node_outline: #0A2040,
	
	bone: #2E6AAF,
	bone_selected: #BF4D20,
	
	node_selected: #FF6B35,
	node_outline_selected: #7A2E10,
}

function draw_rig(rig, scale = 1){
	var size = 16;
	var outline = 2;
	
	draw_node(rig, rig.root, size, outline, scale)
	
	for(var i = 1; i < array_length(rig.nodes); i++) {
		var node = rig.nodes[i];
		
		if (node.connected) draw_bone(node, size, outline, scale);
		else draw_bone_dotted(node, size, outline, scale);
	}
	
	for(var i = 1; i < array_length(rig.nodes); i++) {
		var node = rig.nodes[i];
		draw_node(rig, node, size, outline, scale);
	}
}

function draw_node(rig, node, size, outline, scale) {
	var isSelected = (node == selected.node);
	var color = (isSelected ? skeleton_debug_pallette.node_selected : skeleton_debug_pallette.node);
	var outline_color = (isSelected ? skeleton_debug_pallette.node_outline_selected : ((node == rig.root) ? c_white : skeleton_debug_pallette.node_outline));
	
	//render
	draw_circle_color(x + node.x, y + node.y, (size * scale), outline_color, outline_color, false);
	draw_circle_color(x + node.x, y + node.y, (size - outline) * scale, color, color, false);
}


//bone schenanigans
#macro BONE_START_X node.parent.x + lengthdir_x(18, dir) * scale
#macro BONE_START_Y node.parent.y + lengthdir_y(18, dir) * scale

#macro BONE_END_X node.x - lengthdir_x(18, dir) * scale
#macro BONE_END_Y node.y - lengthdir_y(18, dir) * scale

#macro ELBOW_X lengthdir_x(12 , dir + 90)
#macro ELBOW_Y lengthdir_y(12 , dir + 90)

function draw_bone(node, size, outline, scale) {
	var bone = node.bone;
	var dir = point_direction(node.parent.x, node.parent.y, node.x, node.y);
	var color = (selected.bone == bone) ? skeleton_debug_pallette.bone_selected :  skeleton_debug_pallette.bone;
	var alpha = 0.5;
	
	var multiplier = 0.5;
	
	draw_primitive_begin(pr_trianglelist);
	    draw_vertex_colour(BONE_START_X, BONE_START_Y, color, alpha);
	    draw_vertex_colour(BONE_START_X + ELBOW_X * scale + lengthdir_x(size, dir), BONE_START_Y + ELBOW_Y * scale + lengthdir_y(size, dir), color, alpha);
	    draw_vertex_colour(BONE_END_X + ELBOW_X * scale * multiplier, BONE_END_Y + ELBOW_Y  * scale * multiplier, color, alpha);
	
	    draw_vertex_colour(BONE_START_X, BONE_START_Y, color, alpha);
	    draw_vertex_colour(BONE_START_X - ELBOW_X * scale + lengthdir_x(size, dir), BONE_START_Y - ELBOW_Y * scale + lengthdir_y(size, dir), color, alpha);
	    draw_vertex_colour(BONE_END_X - ELBOW_X  * scale * multiplier, BONE_END_Y - ELBOW_Y * scale * multiplier, color, alpha);
		
	    draw_vertex_colour(BONE_END_X + ELBOW_X * scale * multiplier, BONE_END_Y + ELBOW_Y * scale * multiplier, color, alpha);
	    draw_vertex_colour(BONE_END_X - ELBOW_X * scale * multiplier, BONE_END_Y - ELBOW_Y * scale * multiplier, color, alpha);
	    draw_vertex_colour(BONE_START_X, BONE_START_Y, color, alpha);
	draw_primitive_end();
}

function draw_bone_dotted(node, size, outline, scale){
	var bone = node.bone;
	var dir = point_direction(node.parent.x, node.parent.y, node.x, node.y);
	var color = (selected.bone == bone)
		? skeleton_debug_pallette.bone_selected
		: skeleton_debug_pallette.bone;

	var alpha = 0.5;

	var dist = point_distance(BONE_START_X, BONE_START_Y, BONE_END_X, BONE_END_Y);

	var dash = size * scale;
	var gap  = 4 * scale;
	var thickness = 2 * scale;

	var nx = lengthdir_x(thickness, dir + 90);
	var ny = lengthdir_y(thickness, dir + 90);

	draw_primitive_begin(pr_trianglelist);

	var pos = 0;

	while (pos < dist)
	{
		var seg_start = pos;
		var seg_end = min(pos + dash, dist);

		var sx = BONE_START_X + lengthdir_x(seg_start, dir);
		var sy = BONE_START_Y + lengthdir_y(seg_start, dir);

		var ex = BONE_START_X + lengthdir_x(seg_end, dir);
		var ey = BONE_START_Y + lengthdir_y(seg_end, dir);

		draw_vertex_colour(sx + nx, sy + ny, color, alpha);
		draw_vertex_colour(ex + nx, ey + ny, color, alpha);
		draw_vertex_colour(ex - nx, ey - ny, color, alpha);

		draw_vertex_colour(sx + nx, sy + ny, color, alpha);
		draw_vertex_colour(ex - nx, ey - ny, color, alpha);
		draw_vertex_colour(sx - nx, sy - ny, color, alpha);

		pos += dash + gap;
	}

	draw_primitive_end();
}