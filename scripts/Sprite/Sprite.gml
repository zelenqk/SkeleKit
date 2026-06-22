globalvar spriteList, spriteMap;

spriteList = [];

function Sprite(p) constructor {
	
	path = string_trim(p);
	name = string_replace_all(filename_name(path), filename_ext(path), "");
	
	index = sprite_add(path, 1, true, true, 0, 0);
	
	if (index == -1) {
		show_debug_message("FILE=[" + path + "]");
	}else array_push(spriteList, self);
}