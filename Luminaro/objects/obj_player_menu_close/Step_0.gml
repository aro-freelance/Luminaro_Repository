

if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){


	if(global.player_menu.state != E_PLAYER_MENU_STATE.DISPLAY_STATS && global.player_menu.state != E_PLAYER_MENU_STATE.LEVEL_UP){
		global.player_menu.state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
		global.player_menu.init = false;
	}
	else{
		global.game_state = E_GAME_STATE.PLAYING;
		instance_activate_all();
		//destroy this menu
		with(obj_player_menu){
			instance_destroy();
		}
	}
	

}




