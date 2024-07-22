

if(global.game_state == E_GAME_STATE.PLAYING){

#region Center Camera on Player

camera_set_view_pos(view_camera[0], global.player.x - display_get_gui_width()/2, global.player.y - display_get_gui_height() + distance_between_player_and_camera_bottom);

#endregion
	

#region INPUT: Open Game Menu

if(keyboard_check_pressed(vk_f1)){
	global.game_state = E_GAME_STATE.IN_GAME_MENU;
	global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
	global.player_menu.state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
}


#endregion


}


#region INPUT: show enemy states

if(keyboard_check_pressed(vk_f8)){
	
	with(obj_enemy){
		show_debug_message("enemy states: type = " + string(enemy_type) + ". jump state = " + string(jump_state) + ". standing state = " + string(standing_state) + ". attack state = " + string(attack_state) + ". react state = " + string(react_state) + ". tactics state = " + string(tactic_state) );
	}
}


#endregion



