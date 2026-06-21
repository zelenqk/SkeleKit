function convert_color_to_array(color){
	return [
		color_get_red(color) / 255,
		color_get_green(color) / 255,
		color_get_blue(color) / 255,
	]
}