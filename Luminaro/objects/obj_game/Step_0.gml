



if(global.game_state == E_GAME_STATE.PLAYING){
	
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

if(keyboard_check_pressed(vk_f1)){
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
	
	global.game_state = E_GAME_STATE.IN_GAME_MENU;
	global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
	global.player_menu.state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
}


#endregion


#region Testing

	#region INPUT: show enemy states

	if(keyboard_check_pressed(vk_f8)){
	
		with(obj_enemy){
			show_debug_message("enemy states: type = " + string(enemy_type) + ". jump state = " + string(jump_state) + ". standing state = " + string(standing_state) + ". attack state = " + string(attack_state) + ". react state = " + string(react_state) + ". tactics state = " + string(tactic_state) );
		}
	}


	#endregion



	#region INPUT: level up


	if(keyboard_check_pressed(vk_f5)){
	
		global.player.xp += 90;

	}

	#endregion


	#region INPUT: add inventory item

	if(keyboard_check_pressed(vk_f2)){	
		randomize();
	
		//var item_type = irandom_range(0, (E_INVENTORY_ITEM_TYPES.last - 1));
	
		var item_type = irandom_range(0, 2);
	
		if(array_length(global.player.inventory) < global.player.inventory_max){
				array_push(global.player.inventory, item_type);
				show_debug_message("add item type " + string(item_type));
			 }
			 else{
				//TODO: tell play inventory full
				show_debug_message("inventory is full");
			 }

	}

	#endregion


	#region INPUT: show message
	
	if(keyboard_check_pressed(vk_f9)){	
		var message_window = instance_create_layer(global.dg_width/2, global.dg_height/2, "UI", obj_message);
		message_window.text_array = ["first string", "second string", "third string"];
		var long_string = " fourth string: mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm mmmmmmmmmmmmmmmmmmmm";
		array_push(message_window.text_array, long_string);
		message_window.x_scale = .3;
		message_window.y_scale = .75;
	}
	
	#endregion
	
	
	#region INPUT: damage player
	
	if(keyboard_check_pressed(vk_end)){
		global.player.dynamic_hp -= 20;
		
	}
	
	#endregion

#endregion

}





