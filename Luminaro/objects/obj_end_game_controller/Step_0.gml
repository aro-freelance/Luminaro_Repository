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
}

}

if(!init){

	init = true;

	display_width = global.dg_width;
	display_height = global.dg_height;


	button_width = sprite_get_width(spr_button);
	button_height = sprite_get_height(spr_button);

	text_area_width = 2*display_width/3;
	text_area_height = 2*display_height/3;

	x1 = display_width/6;
	x2 = x1 + text_area_width;
	y1 = display_height/6;
	y2 = y1 + text_area_height;



	var main_menu_button = instance_create_layer(display_width/2, display_height - display_height/12, "Instances", obj_button_room_change);
	main_menu_button.label = "Main Menu";
	main_menu_button.destination_room = rm_main_menu;
}