
if(!init){
	init = true;
	
	//pause the game
	instance_deactivate_all(true);
	
	instance_activate_object(self);
	instance_activate_object(obj_lighting_effects);
	
	
	#region Level up
	
	#region Increase Random Stat
	
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
	
	
	scr_set_player_stats(global.player);
	
	
	//TODO: add interface for letting player choose parameter to improve
	
		
	#endregion

	
}

	
if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1) || (mouse_check_button_pressed(mb_left) && state == E_PLAYER_MENU_STATE.LEVEL_UP)){
	global.game_state = E_GAME_STATE.PLAYING;
	instance_activate_all();
	//destroy this menu
	instance_destroy();
}