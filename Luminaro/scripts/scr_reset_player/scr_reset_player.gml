
//turn off all weapons and reset player to static stats

function scr_reset_player(){
	
	show_debug_message("ping reset player")

	global.button_held =  E_BUTTON_HELD.NONE;

	with(global.player){
	
		jump_state = E_JUMP_STATE.GROUNDED;
		standing_state = E_STANDING_STATE.STANDING;
		attack_state = E_ATTACK_STATE.idle;
		react_state = E_REACT_STATE.idle;
		facing = E_FACING.right;
	
		boss_defeated = false;
		has_required_item = false;
		transition_spawned = false;
	
		dynamic_movement_speed = static_movement_speed;
		dynamic_jump_height = static_jump_height;
		dynamic_jump_number = 2;  //static_jump_number; //How many jumps the player can make
		dynamic_jump_float_time = static_jump_float_time //how long after jump does player hover
		dynamic_beam_speed = static_beam_speed;
		dynamic_light_intensity_mod = static_light_intensity_mod;
		//dynamic_max_mirrors = static_max_mirrors;
		dynamic_prism_beam_number = static_prism_beam_number;
		dynamic_battery = static_battery;
		dynamic_battery_charge_delay = static_battery_charge_delay;
		dynamic_lantern_size_mod = static_lantern_size_mod;
		dynamic_beam_length_mod = static_beam_length_mod;
		dynamic_catalyst_number = static_catalyst_number;
		dynamic_catalyst_charge_delay = static_catalyst_charge_delay;
		dynamic_catalyst_size_mod = static_catalyst_size_mod;
		dynamic_hp = static_hp; //aka current hp
		jump_current = 0; //How many jumps the player has used (compared to dynamic_jump_number to determine if player is allowed to jump)
		jump_float_counter = 0; //how long has player been floating? (compared to dynamic_jump_float_tme)


		
		on_timer = 0; //drain battery counter
		battery_charge_timer = 0; //battery charge counter
		battery_charged = true; //is the battery ready?

		mirrors = [];
		
		catalyst_charge_timer = 0;
		current_catalyst_charges = 0;
		current_spawned_catalysts = 0;

		//inventory = [];
		
		display_message_on = false;
		display_message_timer = 0;
		display_message = "";
		
		special_display_message_on = false;
		special_display_message_timer = 0;
		special_display_message = "";
		

		lantern = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Weapons", obj_light);
		lantern.light_type = E_LIGHT_TYPES.PLAYER_LANTERN;
		lantern.holder = self;
		lantern.is_on = true;


		beam_holding_height = 3*sprite_get_height(sprite_index)/4;
		beam = instance_create_layer(x, y - beam_holding_height, "Weapons", obj_light_beam);
		beam.light_type = E_LIGHT_TYPES.PLAYER_BEAM;
		beam.holder = self;
		beam.is_on = false;

			
	}


}