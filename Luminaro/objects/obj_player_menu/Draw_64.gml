
//draw background
draw_rectangle_color(x1, y1, x2, y2, c_blue, c_blue, c_blue, c_blue, false);




#region Display Stats

if(state == E_PLAYER_MENU_STATE.DISPLAY_STATS){

		draw_set_font(ft_1);
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		

		draw_text(x1 + margin, y1 + (3*margin), "Movement Speed Level: " + string(global.player.l_movement_speed));
		draw_text(x1 + margin, y1 + (5*margin), "Jump Height Level: " + string(global.player.l_jump_height));
		draw_text(x1 + margin, y1 + (7*margin), "Jump Float Time Level: " + string(global.player.l_jump_float_time));
		draw_text(x1 + margin, y1 + (9*margin), "Beam Growth Speed Level: " + string(global.player.l_beam_speed));
		draw_text(x1 + margin, y1 + (11*margin), "Light Intensity Mod Level: " + string(global.player.l_light_intensity_mod));
		draw_text(x1 + margin, y1 + (13*margin), "Prism Beam Number Level: " + string(global.player.l_prism_beam_number));
		draw_text(x1 + margin, y1 + (15*margin), "Battery Max Level: " + string(global.player.l_battery));
		draw_text(x1 + margin, y1 + (17*margin), "Battery Charge Delay Level: " + string(global.player.l_battery_charge_delay));
		draw_text(x1 + margin, y1 + (19*margin), "Lantern Size Level: " + string(global.player.l_lantern_size_mod));
		draw_text(x1 + margin, y1 + (21*margin), "Beam Length Level: " + string(global.player.l_beam_length_mod));
		draw_text(x1 + margin, y1 + (23*margin), "Catalyst Number Level: " + string(global.player.l_catalyst_number));
		draw_text(x1 + margin, y1 + (25*margin), "Catalyst Charge Delay Level: " + string(global.player.l_catalyst_charge_delay));
		draw_text(x1 + margin, y1 + (27*margin), "Catalyst Size Mod Level: " + string(global.player.l_catalyst_size_mod));
		draw_text(x1 + margin, y1 + (29*margin), "HP Level: " + string(global.player.l_hp));

}

#endregion
	
	
#region Level Up

else if(state == E_PLAYER_MENU_STATE.LEVEL_UP){
	
	draw_set_font(ft_1_large);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);

		
	draw_text(display_center_x, display_center_y - menu_height/2 + (5*margin), "Level Up!");
		
	draw_set_font(ft_1);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);	
	
	for(i = 0; i < array_length(level_up_results); i++){
		
		var result_string = "";
		
		switch(array_get(level_up_results, i)){
			case E_PLAYER_PARAMETERS.MOVEMENT_SPEED:
				result_string = "Movement Speed: + 1"
				break;
			case E_PLAYER_PARAMETERS.JUMP_HEIGHT:
				result_string = "Jump Height: + 1"
				break;
			case E_PLAYER_PARAMETERS.JUMP_FLOAT_TIME:
				result_string = "Jump Float Time: + 1"
				break;
			case E_PLAYER_PARAMETERS.BEAM_SPEED:
				result_string = "Beam Speed: + 1"
				break;
			case E_PLAYER_PARAMETERS.BEAM_INTENSITY_MOD:
				result_string = "Light Intensity: + 1"
				break;
			case E_PLAYER_PARAMETERS.PRISM_BEAM_NUMBER:
				result_string = "Prism Beam Number: + 1"
				break;
			case E_PLAYER_PARAMETERS.BATTERY:
				result_string = "Battery: + 1"
				break;
			case E_PLAYER_PARAMETERS.BATTERY_CHARGE_DELAY:
				result_string = "Battery Charge Delay: + 1"
				break;
			case E_PLAYER_PARAMETERS.LANTERN_SIZE_MOD:
				result_string = "Lantern Size: + 1"
				break;
			case E_PLAYER_PARAMETERS.BEAM_LENGTH_MOD:
				result_string = "Beam Length Mod: + 1"
				break;
			case E_PLAYER_PARAMETERS.CATALYST_NUMBER:
				result_string = "Catalyst Number: + 1"
				break;
			case E_PLAYER_PARAMETERS.CATALYST_CHARGE_DELAY:
				result_string = "Catalyst Charge Delay: + 1"
				break;
			case E_PLAYER_PARAMETERS.CATALYST_SIZE_MOD:
				result_string = "Catalyst Size Mod: + 1"
				break;
			case E_PLAYER_PARAMETERS.HP:
				result_string = "HP Level: + 1"
				break;
			default:
				result_string = "Error. Level up result out of range."
				show_debug_message("obj_player_menu: draw gui: level up result out of range");
				break;
		}
		
		
		draw_text(display_center_x, display_center_y + (margin * i), result_string);
	}
		

}

#endregion


#region Save / Load / Exit

else if(state == E_PLAYER_MENU_STATE.SAVE_LOAD_EXIT){



}

#endregion


#region Settings

else if(state == E_PLAYER_MENU_STATE.SETTINGS){



}

#endregion
	
	





