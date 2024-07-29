
// set/refresh player stats

//if should keep hp is set to true this script will set the dynamic hp to the player's current hp



function scr_set_player_stats(player, should_keep_hp = false){
	
	show_debug_message("set stats to player");
	
	player.static_movement_speed = global.baseline_movement_speed + (player.l_movement_speed * global.d_movement_speed);

	player.static_jump_height = global.baseline_jump_height + (player.l_jump_height * global.d_jump_height);
	//player.static_jump_number = global.baseline_jump_number + (player.l_jump_number * global.d_jump_number); //How many jumps the player can make
	player.static_jump_float_time = global.baseline_jump_float_time + (player.l_jump_float_time * global.d_jump_float_time); //how long after jump does player hover

	player.static_beam_speed = global.baseline_beam_speed + (player.l_beam_speed * global.d_beam_speed);
	player.static_light_intensity_mod = global.baseline_light_intensity_mod + (player.l_light_intensity_mod * global.d_light_intensity_mod);

	//player.static_max_mirrors = global.baseline_max_mirrors + (player.l_max_mirrors * global.d_max_mirrors);

	player.static_prism_beam_number = global.baseline_prism_beam_number + (player.l_prism_beam_number * global.d_prism_beam_number);


	player.static_battery = global.baseline_battery + (player.l_battery * global.d_battery); //battery max on time
	player.static_battery_charge_delay = global.baseline_battery_charge_delay + (player.l_battery_charge_delay * global.d_battery_charge_delay); //how long does the battery take to charge?

	player.static_lantern_size_mod = global.baseline_lantern_size_mod + (player.l_lantern_size_mod * global.d_lantern_size_mod);
	
	player.static_beam_length_mod = global.baseline_beam_length_mod + (player.l_beam_length_mod * global.d_beam_length_mod);

	player.static_catalyst_number = global.baseline_catalyst_number + (player.l_catalyst_number * global.d_catalyst_number);
	player.static_catalyst_charge_delay = global.baseline_catalyst_charge_delay + (player.l_catalyst_charge_delay * global.d_catalyst_charge_delay);
	player.static_catalyst_size_mod = global.baseline_catalyst_size_mod + (player.l_catalyst_size_mod * global.d_catalyst_size_mod);
	

	player.static_hp = global.baseline_hp + (player.level * global.d_hp); //aka total hp


	#endregion


	#region Dynamic Player Parameters

	player.dynamic_movement_speed = player.static_movement_speed;

	player.dynamic_jump_height = player.static_jump_height;
	player.dynamic_jump_number = 2;  //static_jump_number; //How many jumps the player can make
	player.dynamic_jump_float_time = player.static_jump_float_time //how long after jump does player hover


	player.dynamic_beam_speed = player.static_beam_speed;
	player.dynamic_light_intensity_mod = player.static_light_intensity_mod;

	//player.dynamic_max_mirrors = player.static_max_mirrors;

	player.dynamic_prism_beam_number = player.static_prism_beam_number;

	player.dynamic_battery = player.static_battery;
	player.dynamic_battery_charge_delay = player.static_battery_charge_delay;
	
	player.dynamic_lantern_size_mod = player.static_lantern_size_mod;
	
	player.dynamic_beam_length_mod = player.static_beam_length_mod;

	player.dynamic_catalyst_number = player.static_catalyst_number;
	player.dynamic_catalyst_charge_delay = player.static_catalyst_charge_delay;
	player.dynamic_catalyst_size_mod = player.static_catalyst_size_mod;


	if(!should_keep_hp) player.dynamic_hp = player.static_hp; //aka current hp
	
	#endregion
	
	
	#region Inventory Parameters
	
	for(var i = 0; i < array_length(player.inventory); i++){
			
		var item_type = player.inventory[i];
			
		switch(item_type){
				
			case E_INVENTORY_ITEM_TYPES.TYPE_0:
			//firestone
				player.dynamic_light_intensity_mod = player.dynamic_light_intensity_mod + (global.d_light_intensity_mod);
				break;
			case E_INVENTORY_ITEM_TYPES.TYPE_1:
			//mythril
				player.dynamic_catalyst_size_mod = player.dynamic_catalyst_size_mod + (global.d_catalyst_size_mod);
				break;
			case E_INVENTORY_ITEM_TYPES.TYPE_2:
			//fire mythril
				player.dynamic_light_intensity_mod = player.dynamic_light_intensity_mod + (2*global.d_light_intensity_mod);
				player.dynamic_catalyst_size_mod = player.dynamic_catalyst_size_mod + (2*global.d_catalyst_size_mod);
				break;		
		}
	}
	
	#endregion

}