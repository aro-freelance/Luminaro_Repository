

if(global.game_state == E_GAME_STATE.PLAYING){
	
if(global.dg_width != 99*browser_width/100 || global.dg_height != 99*browser_height/100){
	if(os_browser != browser_not_a_browser){
		var _dw = 99*browser_width/100;
		var _dh = 99*browser_height/100;
	
		display_set_gui_size(_dw, _dh);
		camera_set_view_size(view_camera[0], _dw, _dh);
		surface_resize(application_surface, _dw, _dh);
		window_set_rectangle(0, 0, _dw, _dh);
		global.dg_width = display_get_gui_width();
		global.dg_height = display_get_gui_height();
	}
}
	
if(!init){
	init = true;

	hp_bar_width = 600;
	hp_bar_height = 50;


	hp_bar_x1 = global.dg_width - margin - hp_bar_width;
	hp_bar_x2 = hp_bar_x1 + hp_bar_width;

	hp_bar_y1 = margin;
	hp_bar_y2 = hp_bar_y1 + hp_bar_height;


	battery_bar_width = 600;
	battery_bar_height = 50;
	battery_bar_color = c_green; //uncharged color is in draw gui

	battery_bar_x1 = global.dg_width - margin - battery_bar_width;
	battery_bar_x2 = battery_bar_x1 + battery_bar_width;

	battery_bar_y1 = global.dg_height - margin - battery_bar_height;
	battery_bar_y2 = battery_bar_y1 + battery_bar_height;


	xp_bar_width = 400;
	xp_bar_height = 30;

	xp_bar_x1 = margin;
	xp_bar_x2 = xp_bar_x1 + xp_bar_width;

	xp_bar_y1 = margin;
	xp_bar_y2 = xp_bar_y1 + xp_bar_height;


}
	



#region Center Camera on Player

if(global.player != noone) camera_set_view_pos(view_camera[0], global.player.x - global.dg_width/2, global.player.y - global.dg_height + distance_between_player_and_camera_bottom);

#endregion
	

#region INPUT: Open Game Menu

if(keyboard_check_pressed(vk_f1) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(ord("M"))){
	
	global.game_state = E_GAME_STATE.IN_GAME_MENU;
	global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
	global.player_menu.state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
}


#endregion








#endregion

}





