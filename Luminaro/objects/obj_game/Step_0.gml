

if(global.game_state == E_GAME_STATE.PLAYING){

#region INPUT: Open Game Menu

if(keyboard_check_pressed(vk_f1)){
	global.game_state = E_GAME_STATE.IN_GAME_MENU;
	global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
	global.player_menu.state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
}


#endregion


}




