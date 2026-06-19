function Grid() constructor{
	size = 32;
	width = 12;
	
	line = #1A1D27;
	origin = #2E3445;
	
	//cache
	vertex_format_begin();
	vertex_format_add_position();
	vertex_format_add_color();
	format = vertex_format_end();
	
	vertex = vertex_create_buffer();
	
	
	//methods
	static build = function() {
		vertex_begin(vertex, format);
		
		var index = 0;
		repeat (width * 2){
			var color = (index == width) ? origin : line;
			
			vertex_position(vertex, size * index - width * size, -width * size);
			vertex_color(vertex, color, 1);
			vertex_position(vertex, size * index - width * size, width * size);
			vertex_color(vertex, color, 1);

			vertex_position(vertex, -width * size, size * index - width * size);
			vertex_color(vertex, color, 1);
			vertex_position(vertex, width * size, size * index - width * size);
			vertex_color(vertex, color, 1);

			index++;
		}
		
		vertex_end(vertex);
	}
	
	static snap = function(tx, ty) {
		var sx = round(tx / size);
		var sy = round(ty / size);
		
		return {x: sx * size, y: sy * size};
	}
	
	static set_size = function(s = size, w = width) {
		size = s;
		width = w;
		
		build();
	}
	
	static cleanup = function(){
		vertex_delete_buffer(vertex);
		vertex_format_delete(format);
	}
	
	static draw = function() {
		vertex_submit(vertex, pr_linelist, -1);
	}
}