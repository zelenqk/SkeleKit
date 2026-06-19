globalvar SURFACES_LIST;
SURFACES_LIST = [];

function surface_purge() {
	var i = 0;
	var length = array_length(SURFACES_LIST);
	
	repeat (length) {
		var surface = SURFACES_LIST[i++];
		if (!surface.dead) surface.cleanup();
	}
}

function Surface(w, h, pad = 0, f = surface_rgba8unorm) constructor{
	array_push(SURFACES_LIST, self);

	dead = false;
	
	x = 0;
	y = 0;
	
	padding = pad;
	width = w;
	height = h;
	format = f;
	
	index = surface_create(width + padding, height + padding, format);
	texture = surface_get_texture(index);
	
	above = -1;
	
	static resurface = function() {
		if (!window_has_focus()) return false;
		
		surface_free(index);
		index = surface_create(width + padding, height + padding, format);
		texture = surface_get_texture(index);
		dead = false;
		
		return true;
	}
	
	static resize = function(w, h, f = format) {
		width = w;
		height = h;
		format = f;
		
		if (exists(false)) resurface();
	}
	
	static exists = function(resurf) {
		if (surface_exists(index)) return true;
		if (resurf) return resurface();
		return false
	}
	
	static target = function(resurf = true) {
		var current = surface_get_target();
		if (current != -1) {
			above = current;
			surface_reset_target();	
		}
		
		if (exists(resurf)) surface_set_target(index);	
	}
	
	static reset = function(){
		if (surface_get_target() != -1) surface_reset_target();
		if (above != -1) surface_set_target(above);
	}
	
	static draw = function(tx = x, ty = y) {
		if (exists(false)) draw_surface(index, tx, ty);
	}
	
	static cleanup = function() {
		surface_free(index);
		dead = true;
	}
}