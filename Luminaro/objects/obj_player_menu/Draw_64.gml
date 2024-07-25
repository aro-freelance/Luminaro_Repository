
//draw background
draw_rectangle_color(x1, y1, x2, y2, c_blue, c_blue, c_blue, c_blue, false);




#region Display Stats

if(state == E_PLAYER_MENU_STATE.DISPLAY_STATS){

		draw_set_font(fnt_1);
		draw_set_color(c_white);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		

		
		draw_text(display_center_x + 2*margin, y1 + (3*margin), "Movement Speed Upgrades: " + string(global.player.l_movement_speed));
		draw_text(display_center_x + 2*margin, y1 + (5*margin), "Jump Height Upgrades: " + string(global.player.l_jump_height));
		draw_text(display_center_x + 2*margin, y1 + (7*margin), "Jump Float Time Upgrades: " + string(global.player.l_jump_float_time));
		draw_text(display_center_x + 2*margin, y1 + (9*margin), "Beam Growth Speed Upgrades: " + string(global.player.l_beam_speed));
		draw_text(display_center_x + 2*margin, y1 + (11*margin), "Light Intensity Mod Upgrades: " + string(global.player.l_light_intensity_mod));
		draw_text(display_center_x + 2*margin, y1 + (13*margin), "Prism Beam Number Upgrades: " + string(global.player.l_prism_beam_number));
		draw_text(display_center_x + 2*margin, y1 + (15*margin), "Battery Max Upgrades: " + string(global.player.l_battery));
		draw_text(display_center_x + 2*margin, y1 + (17*margin), "Battery Charge Delay Upgrades: " + string(global.player.l_battery_charge_delay));
		draw_text(display_center_x + 2*margin, y1 + (19*margin), "Lantern Size Upgrades: " + string(global.player.l_lantern_size_mod));
		draw_text(display_center_x + 2*margin, y1 + (21*margin), "Beam Length Upgrades: " + string(global.player.l_beam_length_mod));
		draw_text(display_center_x + 2*margin, y1 + (23*margin), "Catalyst Number Upgrades: " + string(global.player.l_catalyst_number));
		draw_text(display_center_x + 2*margin, y1 + (25*margin), "Catalyst Charge Delay Upgrades: " + string(global.player.l_catalyst_charge_delay));
		draw_text(display_center_x + 2*margin, y1 + (27*margin), "Catalyst Size Mod Upgrades: " + string(global.player.l_catalyst_size_mod));
		
		
		draw_text(x1 + 2*margin, y1 + (3*margin), "Player Level: " + string(global.player.level));
		draw_text(x1 + 2*margin, y1 + (7*margin), "HP : " + string(global.player.dynamic_hp) + " / " + string(global.player.static_hp));
		draw_text(x1 + 2*margin, y1 + (9*margin), "Battery Max Time : " + string(round(global.player.dynamic_battery*10)/10) + " seconds");
		draw_text(x1 + 2*margin, y1 + (11*margin), "Enemies Defeated : " + string(array_length(global.player.enemies_defeated) + array_length(global.player.bosses_defeated)));
		draw_text(x1 + 2*margin, y1 + (13*margin), "Shadows Defeated : " + string(array_length(global.player.shadows_defeated)));
		
}

#endregion
	
	
#region Level Up

else if(state == E_PLAYER_MENU_STATE.LEVEL_UP){
	
	draw_set_font(fnt_1_large);
	draw_set_color(c_white);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);

		
	draw_text(display_center_x, display_center_y - menu_height/2 + (5*margin), "Level Up!");
		
	draw_set_font(fnt_1);
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

#region Inventory

else if(state == E_PLAYER_MENU_STATE.INVENTORY){

	draw_rectangle_color(display_center_x + sprite_get_width(spr_inventory_item), y1 + margin, x2 - margin, y2 - margin, c_aqua, c_aqua, c_aqua, c_aqua, false);
	
	draw_set_font(fnt_1);
	draw_set_color(c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	var combine_item_x = display_center_x + margin + 1*sprite_get_width(spr_inventory_item);
	var combine_item_y =  y1 + 2*margin;
	//var c_1_string = "description 1 mmmmmmmm description 1 description 1 description 1"  //example string.  end of mmms in max length of one line. max four lines.
	if(selected_item_type_1 != -1) {
		var type_1_string = global.combine_descriptions[# selected_item_type_1, selected_item_type_1];
		
		draw_sprite_ext(spr_inventory_item, selected_item_type_1, combine_item_x, combine_item_y, combine_sprite_scale, combine_sprite_scale, 0, c_white, 1);
		draw_rectangle(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item), combine_item_y, combine_item_x + margin + 3*combine_sprite_scale*sprite_get_width(spr_inventory_item), y1 + 2*margin + combine_sprite_scale*sprite_get_height(spr_inventory_item), true);
		draw_text_ext(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item) + combine_text_spacing, combine_item_y, type_1_string, sep, 2*combine_sprite_scale*sprite_get_width(spr_inventory_item));
	}
	if(selected_item_type_2 != -1) {
		var type_2_string = global.combine_descriptions[# selected_item_type_2, selected_item_type_2];
		
		draw_sprite_ext(spr_inventory_item, selected_item_type_2, combine_item_x, combine_item_y + ( margin + combine_sprite_scale*sprite_get_height(spr_inventory_item)), combine_sprite_scale, combine_sprite_scale, 0, c_white, 1);
		draw_rectangle(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item), combine_item_y + ( margin + combine_sprite_scale*sprite_get_height(spr_inventory_item)), combine_item_x + margin + 3*combine_sprite_scale*sprite_get_width(spr_inventory_item), y1 + 2*margin + ( margin + 2*combine_sprite_scale*sprite_get_height(spr_inventory_item)), true);
		draw_text_ext(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item) + combine_text_spacing, combine_item_y + ( margin + combine_sprite_scale*sprite_get_height(spr_inventory_item)), type_2_string, sep, 2*combine_sprite_scale*sprite_get_width(spr_inventory_item));
	}
	if(selected_item_type_1 != -1 && selected_item_type_2 != -1) {
		var combine_string = global.combine_descriptions[# selected_item_type_1, selected_item_type_2];
		
		draw_sprite_ext(spr_inventory_item_blank, 0, combine_item_x, combine_item_y + 2*( margin + combine_sprite_scale*sprite_get_height(spr_inventory_item)), combine_sprite_scale, combine_sprite_scale, 0, c_white, 1);	
		draw_rectangle(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item), combine_item_y + ( 2*margin + 2*combine_sprite_scale*sprite_get_height(spr_inventory_item)), combine_item_x + margin + 3*combine_sprite_scale*sprite_get_width(spr_inventory_item), y1 + 2*margin + ( 2*margin + 3*combine_sprite_scale*sprite_get_height(spr_inventory_item)), true);
		draw_text_ext(combine_item_x + margin + combine_sprite_scale*sprite_get_width(spr_inventory_item) + combine_text_spacing, combine_item_y + ( 2*margin + 2*combine_sprite_scale*sprite_get_height(spr_inventory_item)), combine_string, sep, 2*combine_sprite_scale*sprite_get_width(spr_inventory_item));
	}
	
	

}

#endregion


#region Settings

else if(state == E_PLAYER_MENU_STATE.SETTINGS){



}

#endregion


#region Save / Load / Exit

else if(state == E_PLAYER_MENU_STATE.SAVE_LOAD_EXIT){



}

#endregion



	
	





