
#region Init

if(!init){
	init = true;
	
	#region Pause the game
	
		global.button_held_time = 0;
		global.button_held = E_BUTTON_HELD.NONE;
	
		instance_deactivate_all(true);
	
		instance_activate_object(self);
		instance_activate_object(obj_lighting_effects);
	
	#endregion
	
	//remove buttons
	with(obj_template_player_menu_mode_button){
		instance_destroy();
	}


	#region Display Stats

	if(state == E_PLAYER_MENU_STATE.DISPLAY_STATS){
		show_debug_message("player menu init: display stats");

		var button1 = instance_create_layer(display_center_x - menu_width/2 + margin + button_width/2, display_center_y + menu_height/2 - margin - button_height/2, "UI", obj_template_player_menu_mode_button);
		button1.destination_type = E_PLAYER_MENU_STATE.SETTINGS;
		button1.label = "Settings";

		
		var button2 = instance_create_layer(display_center_x + menu_width/2 - margin - button_width/2, display_center_y + menu_height/2 - margin - button_height/2, "UI", obj_template_player_menu_mode_button);
		button2.destination_type = E_PLAYER_MENU_STATE.SAVE_LOAD_EXIT;
		button2.label = "Save/Load/Exit";
		

	}

	#endregion
	
	
	#region Level up
	
	else if(state == E_PLAYER_MENU_STATE.LEVEL_UP){
	
		show_debug_message("player menu init: level up");
	
		#region Increase Random Stat
	
	//TODO: for loop here for multiple stat increase
		randomize();
	
		var random_parameter = irandom_range(0, (E_PLAYER_PARAMETERS.last - 1));
	
		switch(random_parameter){
			case E_PLAYER_PARAMETERS.MOVEMENT_SPEED:
				global.player.l_movement_speed++;
				show_debug_message("movement up");
				break;
			case E_PLAYER_PARAMETERS.JUMP_HEIGHT:
				global.player.l_jump_height++;
				show_debug_message("jump height up");
				break;
			case E_PLAYER_PARAMETERS.JUMP_FLOAT_TIME:
				global.player.l_jump_float_time++;
				show_debug_message("jump float time up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_SPEED:
				global.player.l_beam_speed++;
				show_debug_message("beam speed up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_INTENSITY_MOD:
				global.player.l_light_intensity_mod++;
				show_debug_message("beam intensity mod up");
				break;
			case E_PLAYER_PARAMETERS.PRISM_BEAM_NUMBER:
				global.player.l_prism_beam_number++;
				show_debug_message("prism beam number up");
				break;
			case E_PLAYER_PARAMETERS.BATTERY:
				global.player.l_battery++;
				show_debug_message("battery up");
				break;
			case E_PLAYER_PARAMETERS.BATTERY_CHARGE_DELAY:
				global.player.l_battery_charge_delay++;
				show_debug_message("battery charge delay level up");
				break;
			case E_PLAYER_PARAMETERS.LANTERN_SIZE_MOD:
				global.player.l_lantern_size_mod++;
				show_debug_message("lantern size mod up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_LENGTH_MOD:
				global.player.l_beam_length_mod++;
				show_debug_message("beam length mod up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_NUMBER:
				global.player.l_catalyst_number++;
				show_debug_message("catalyst number up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_CHARGE_DELAY:
				global.player.l_catalyst_charge_delay++;
				show_debug_message("catalyst charge delay up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_SIZE_MOD:
				global.player.l_catalyst_size_mod++;
				show_debug_message("catalyst size mod up");
				break;
			case E_PLAYER_PARAMETERS.HP:
				global.player.l_hp++;
				show_debug_message("hp up");
				break;
			default:
				global.player.l_hp++;
				show_debug_message("hp up");
				break;
			
		}
	
		#endregion
	
		array_push(level_up_results, random_parameter);
		scr_set_player_stats(global.player);
	
	
		//TODO: add interface for letting player choose parameter to improve
	
	}
		
	#endregion

	#region Save / Load / Exit

	else if(state == E_PLAYER_MENU_STATE.SAVE_LOAD_EXIT){
		show_debug_message("player menu init: save load exit");
		//TODO: show stuff for save load and exit

	}

	#endregion


	#region Settings

	else if(state == E_PLAYER_MENU_STATE.SETTINGS){
		show_debug_message("player menu init: settings");
		//TODO: show stuff for settings

	}

	#endregion

	
}

#endregion





#region INPUT: Go back / Close
if(state != E_PLAYER_MENU_STATE.DISPLAY_STATS && state != E_PLAYER_MENU_STATE.LEVEL_UP){
	if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1) || (mouse_check_button_pressed(mb_left) && state == E_PLAYER_MENU_STATE.LEVEL_UP)){
		state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
		init = false;
	}
}
else{
	if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1) || (mouse_check_button_pressed(mb_left) && state == E_PLAYER_MENU_STATE.LEVEL_UP)){
		global.game_state = E_GAME_STATE.PLAYING;
		instance_activate_all();
		//destroy this menu
		instance_destroy();
	}
}

#endregion




