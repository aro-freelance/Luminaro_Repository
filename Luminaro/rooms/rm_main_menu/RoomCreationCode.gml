if(os_browser != browser_not_a_browser){
	var _dw = 99*browser_width/100;
	var _dh = 99*browser_height/100;
	
	display_set_gui_size(_dw, _dh);
	camera_set_view_size(view_camera[0], _dw, _dh);
	surface_resize(application_surface, _dw, _dh);
	window_set_rectangle(0, 0, _dw, _dh);
	
	display_set_gui_size(_dw, _dh);
	global.dg_width = display_get_width();
	global.dg_height = display_get_height();
	
	
	var back = layer_background_get_id("Background");
	layer_background_xscale(back, .85);
	layer_background_yscale(back, .85);
	
}
else{
	window_set_fullscreen(true);
}


/*
if(os_browser != browser_not_a_browser){
	if(browser_width != width || browser_height != height){
		width = browser_width-5;
		height = browser_height-5;
		window_set_size(width, height);
	}
}
*/
