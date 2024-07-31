

if(!init){
	init = true;
	
	
	if(os_browser != browser_not_a_browser){
		var _dw = 99*browser_width/100;
		var _dh = 99*browser_height/100;
	
		display_set_gui_size(_dw, _dh);
		//window_set_size(_dw, _dh);
		camera_set_view_size(view_camera[0], _dw, _dh);
		surface_resize(application_surface, _dw, _dh);
		window_set_rectangle(0, 0, _dw, _dh);
		global.dg_width = display_get_gui_width();
		global.dg_height = display_get_gui_height();
		display_width = global.dg_width;
		display_height = global.dg_height;

	}
	

	



	//TODO: button for display setting options
	//settings_button = instance_create_layer(display_width/2, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
	//settings_button.label = "Settings";
	//settings_button.text_array = ["Settings: \n hello world"];




}



if(global.dg_width != 99*browser_width/100 || global.dg_height != 99*browser_height/100){
	if(os_browser != browser_not_a_browser){
		var _dw = 99*browser_width/100;
		var _dh = 99*browser_height/100;
	
		display_set_gui_size(_dw, _dh);
		//window_set_size(_dw, _dh);
		camera_set_view_size(view_camera[0], _dw, _dh);
		surface_resize(application_surface, _dw, _dh);
		window_set_rectangle(0, 0, _dw, _dh);
		global.dg_width = display_get_gui_width();
		global.dg_height = display_get_gui_height();
		display_width = global.dg_width;
		display_height = global.dg_height;
		
	
		start_button.x = display_width/2
		start_button.y = 2*display_height/3 - button_height/2
	
		help_button.x = display_width/8
		help_button.y = display_height - display_height/12 - button_height/2 - margin
		
		
		credits_button.x = display_width/8
		credits_button.y = display_height - display_height/12 + button_height/2
	

	}

}

