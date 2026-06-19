function Camera() constructor{
	camera = camera_create();
	view = 0;
	
	x = 0;
	y = 0;
	
	width = display_get_gui_width();
	height = display_get_gui_height();

	zoom = 1;
	
	surface = new Surface(width, height);

	//attributes
	panning = false;
	pan = {
		x: 0,
		y: 0,
	}
	
	
	anchor = {
		x: 0.5,
		y: 0.5,
	}
	
	target = {x, y, width, height};
	
	mouse = {
		x: 0,
		y: 0,
	}
	
	//methods
	setup = function() {
		view_enabled = true;
		view_visible[view] = true;
		view_camera[view] = camera;
		
		view_wport[view] = width;
		view_hport[view] = height;
		view_surface_id[view] = surface.index
	}
	
	resize = function(w, h){
		width = w;
		height = h;
		
		view_wport[view] = width;
		view_hport[view] = height;
		
		surface.resize(width, height);
		
		display_set_gui_size(width, height);
	}
	
	step = function(){
		zoom = clamp(zoom + (mouse_wheel_down() - mouse_wheel_up()) * 0.1, 0.1, 10);
		
		var mx = device_mouse_x_to_gui(0)
		var my = device_mouse_y_to_gui(0)
		mouse.x = x - (width * zoom) * anchor.x + mx * ((width * zoom) / width);
		mouse.y = y - (height * zoom) * anchor.y + my * ((height * zoom) / height);
		
		if (mouse_check_button_released(mb_middle)) panning = false;
		if (panning) {
		    x += (pan.x - mx) * zoom;
		    y += (pan.y - device_mouse_y_to_gui(0)) * zoom;
			
		    pan.x = mx;
		    pan.y = my;
			return;
		}
		
		if (mouse_check_button_pressed(mb_middle)) {
			panning = true;
		
			pan.x = mx;
			pan.y = my;
		}
	}
	
	render = function() {
		if (surface.exists(true)) view_surface_id[view] = surface.index;
		
		target.width = width * zoom;
		target.height = height * zoom;
		target.x = x - target.width * anchor.x
		target.y = y - target.height * anchor.y

		camera_set_view_pos(camera, target.x, target.y);
		camera_set_view_size(camera, target.width, target.height);
	}
	
	draw = function(){
		surface.draw();	
	}
	
	cleanup = function(){
		camera_destroy(camera);
	}
}