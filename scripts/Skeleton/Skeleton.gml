
function Skeleton() constructor {
	time = 0;
	animation = pointer_null;
	animations = {};
	
	root = new Node(0, 0);
	nodes = [root];
	
	x = 0;
	y = 0;
	
	//util methods
	add = function(tx, ty, sprite = pointer_null, p = root) {
		var node = new Node(tx, ty, sprite, p, string(array_length(nodes)));
		
		array_push(p.children, node);
		array_push(nodes, node);
		
		return node;
	}
	
	//methods
	step = function(time = 1){
		self.time = (self.time + time) mod animation.length;
		
		var index = 0;
		for (var i = 0; i < array_length(animation.keyframes) - 1; i++) {
		    if (animation.keyframes[i].time <= self.time) index = i;
		}
		
		var keyframe = animation.keyframes[index];
		var next = animation.keyframes[index + 1];
		
		var scale = (self.time - keyframe.time) / (next.time - keyframe.time);
		
		for(var i = 0; i < array_length(keyframe.nodes); i++){
			var node = keyframe.nodes[i];
			var bone = node.bone;
			
			bone.target = lerp(keyframe.direction[i], next.direction[i], scale);
			node.x = node.parent.x + lengthdir_x(bone.length, bone.target);
			node.y = node.parent.y + lengthdir_y(bone.length, bone.target);
		}
	}
	
	draw = function(){
	    for(var i = 0; i < array_length(nodes); i++) {
	        var node = nodes[i];
	        var bone = node.bone;
	        
	        var tx = x + node.parent.x;
	        var ty = y + node.parent.y;
	        
	        if (bone.sprite != -1) {
				var sprite = bone.sprite;
				
				var scale = bone.length / (point_distance(sprite.start.x, sprite.start.y, sprite.finish.x, sprite.finish.y));
				
				var odir = point_direction(0, 0, sprite.start.x, sprite.start.y);
				var olength = point_distance(0, 0, sprite.start.x, sprite.start.y) * scale;
				
				var draw_angle = bone.target - point_direction(sprite.start.x, sprite.start.y, sprite.finish.x, sprite.finish.y);
				
				var ox = lengthdir_x(olength, odir + draw_angle);
				var oy = lengthdir_y(olength, odir + draw_angle);
				
				var xscale = 
				draw_sprite_ext(sprite.index, 0, tx - ox, ty - oy, scale, scale, draw_angle, c_white, 1);
			}
	        
	        draw_line(tx, ty, tx + lengthdir_x(bone.length, bone.target), ty + lengthdir_y(bone.length, bone.target));
	    }
	}
}

function Node(tx, ty, sprite = pointer_null, p = self, name = "") constructor {
	x = tx;
	y = ty;
	depth = 0;
	
	parent = p;
	children = [];
	
	var root = (parent == self);
	self.name = root ? "root" : name;
	connected = !root;
	
	bone = {
		lockLength: false,
		sprite: sprite,
		length: point_distance(parent.x, parent.y, x, y),
		direction: point_direction(parent.x, parent.y, x, y),
		
		target: 0,
	}
}