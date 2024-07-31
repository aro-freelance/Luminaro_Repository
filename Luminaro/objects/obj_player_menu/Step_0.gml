
#region Init

if(!init){
	init = true;
	
	
	#region Pause the game
	
	
		instance_deactivate_all(true);
	
		instance_activate_object(self);
		instance_activate_object(obj_lighting_effects);
	
	#endregion
	
	//remove buttons
	with(obj_player_menu_mode_button){
		instance_destroy();
	}

	var close_button = instance_create_layer(x2 - 2*margin, y1, "UI", obj_player_menu_close);
	

	#region Display Stats

	if(state == E_PLAYER_MENU_STATE.DISPLAY_STATS){
		show_debug_message("player menu init: display stats");

		var button1 = instance_create_layer(display_center_x - menu_width/2 + margin + button_width/2, display_center_y + menu_height/2 - margin - button_height/2, "UI", obj_player_menu_mode_button);
		button1.destination_type = E_PLAYER_MENU_STATE.INVENTORY;
		button1.label = "Inventory";
		
		/*
		var button2 = instance_create_layer(display_center_x, display_center_y + menu_height/2 - margin - button_height/2, "UI", obj_player_menu_mode_button);
		button2.destination_type = E_PLAYER_MENU_STATE.SETTINGS;
		button2.label = "Settings";
		*/
	
		var button3 = instance_create_layer(display_center_x + menu_width/2 - margin - button_width/2, display_center_y + menu_height/2 - margin - button_height/2, "UI", obj_button_room_change);
		button3.destination_room = rm_main_menu;
		button3.label = "Quit"; //"Save/Load/Exit";

	}

	#endregion
	
	#region Level up
	
	else if(state == E_PLAYER_MENU_STATE.LEVEL_UP){
	
		show_debug_message("player menu init: level up");
	
		
		#region Handle Random Level
		
		if(level_option == -1){
			randomize();
	
			level_option = irandom_range(0, (E_PLAYER_PARAMETERS.last - 1));
		}
		
		#endregion
	
	
		switch(level_option){
			case E_PLAYER_PARAMETERS.MOVEMENT_SPEED:
				global.player.l_movement_speed = global.player.l_movement_speed + upgrade_quality;
				show_debug_message("movement up");
				break;
			case E_PLAYER_PARAMETERS.JUMP_HEIGHT:
				global.player.l_jump_height = global.player.l_jump_height + upgrade_quality;
				show_debug_message("jump height up");
				break;
			case E_PLAYER_PARAMETERS.JUMP_FLOAT_TIME:
				global.player.l_jump_float_time = global.player.l_jump_float_time + upgrade_quality;
				show_debug_message("jump float time up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_SPEED:
				global.player.l_beam_speed = global.player.l_beam_speed + upgrade_quality;
				show_debug_message("beam speed up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_INTENSITY_MOD:
				global.player.l_light_intensity_mod = global.player.l_light_intensity_mod + upgrade_quality;
				show_debug_message("beam intensity mod up");
				break;
			case E_PLAYER_PARAMETERS.PRISM_BEAM_NUMBER:
				global.player.l_prism_beam_number = global.player.l_prism_beam_number + upgrade_quality;
				show_debug_message("prism beam number up");
				break;
			case E_PLAYER_PARAMETERS.BATTERY:
				global.player.l_battery = global.player.l_battery + upgrade_quality;
				show_debug_message("battery up");
				break;
			case E_PLAYER_PARAMETERS.BATTERY_CHARGE_DELAY:
				global.player.l_battery_charge_delay = global.player.l_battery_charge_delay + upgrade_quality;
				show_debug_message("battery charge delay level up");
				break;
			case E_PLAYER_PARAMETERS.LANTERN_SIZE_MOD:
				global.player.l_lantern_size_mod = global.player.l_lantern_size_mod + upgrade_quality;
				show_debug_message("lantern size mod up");
				break;
			case E_PLAYER_PARAMETERS.BEAM_LENGTH_MOD:
				global.player.l_beam_length_mod = global.player.l_beam_length_mod + upgrade_quality;
				show_debug_message("beam length mod up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_NUMBER:
				global.player.l_catalyst_number = global.player.l_catalyst_number + upgrade_quality;
				show_debug_message("catalyst number up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_CHARGE_DELAY:
				global.player.l_catalyst_charge_delay = global.player.l_catalyst_charge_delay + upgrade_quality;
				show_debug_message("catalyst charge delay up");
				break;
			case E_PLAYER_PARAMETERS.CATALYST_SIZE_MOD:
				global.player.l_catalyst_size_mod = global.player.l_catalyst_size_mod + upgrade_quality;
				show_debug_message("catalyst size mod up");
				break;
			default:
				show_debug_message("ERROR: DEFAULT CASE ON RANDOM LEVEL UP");
				break;
			
		}
		
		
		global.player.level++;
	
		array_push(level_up_results, level_option);
		scr_set_player_stats(global.player);
	
	
		//TODO: add interface for letting player choose parameter to improve
	
	}
		
	#endregion

	#region Inventory

	else if(state == E_PLAYER_MENU_STATE.INVENTORY){
		show_debug_message("player menu init: inventory");
		
		var counter = 0; 
		var previous_column = 0;
		for(i = 0; i< array_length(global.player.inventory); i++){
			
			var item_type = array_get(global.player.inventory, i);
			
			#region Setup Grid Location
			var height = y1 + margin + (counter * (margin + sprite_get_height(spr_inventory_item)));
			var column = floor( (height + sprite_get_height(spr_inventory_item) - y1) / menu_height) + previous_column;
			var width = x1 + margin + (column * (margin + sprite_get_width(spr_inventory_item)));
			if(column > previous_column){
				counter = 0;
				height = y1 + margin + (counter * (margin + sprite_get_height(spr_inventory_item)));
			}
			previous_column = column;
			counter++;
			
			#endregion 
			
			var inventory_button = instance_create_layer(width, height, "UI", obj_inventory_button);
			inventory_button.item_type = item_type;
			
		}
		
		
		
		var combine_button = instance_create_layer(combine_x, y2 - button_height - margin, "UI", obj_combine_button );
		//set things on combine button here if needed
		
		
		
		
	}

	#endregion

	#region Settings

	else if(state == E_PLAYER_MENU_STATE.SETTINGS){
		show_debug_message("player menu init: settings");
		//TODO: show stuff for settings

	}

	#endregion

	#region Save / Load / Exit

	else if(state == E_PLAYER_MENU_STATE.SAVE_LOAD_EXIT){
		show_debug_message("player menu init: save load exit");
		//TODO: show stuff for save load and exit

	}

	#endregion

	
}

#endregion





#region Display Stats

if(state == E_PLAYER_MENU_STATE.INVENTORY){

	



}

#endregion




#region INPUT: Go back / Close
if(state != E_PLAYER_MENU_STATE.DISPLAY_STATS && state != E_PLAYER_MENU_STATE.LEVEL_UP){
	if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1) || keyboard_check_pressed(ord("M")) || (mouse_check_button_pressed(mb_left) && state == E_PLAYER_MENU_STATE.LEVEL_UP)){
		state = E_PLAYER_MENU_STATE.DISPLAY_STATS;
		init = false;
	}
}
else{
	if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1) || keyboard_check_pressed(ord("M")) || (mouse_check_button_pressed(mb_left) && state == E_PLAYER_MENU_STATE.LEVEL_UP)){
		global.game_state = E_GAME_STATE.PLAYING;
		instance_activate_all();
		//destroy this menu
		instance_destroy();
	}
}

#endregion




