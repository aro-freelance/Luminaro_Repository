/// @description obj_light collision with obj_boss

if(global.game_state == E_GAME_STATE.PLAYING){

	//if the light is turned on
	if(is_on){
	
		//if it is a lantern
		if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
	
		
			other.dynamic_hp = other.dynamic_hp - (intensity*global.player.dynamic_light_intensity_mod);
			//show_debug_message("obj_light collision obj_enemy: enemy collision with lantern. hp = " + string(other.dynamic_hp));

		}

		//if it is a player beam
		else if(light_type == E_LIGHT_TYPES.PLAYER_BEAM){
		
		
	
			if(size == E_LIGHT_SIZE.NORMAL){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) );
			}
			else if (size == E_LIGHT_SIZE.NARROW){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) * 2);
			}
			else if (size == E_LIGHT_SIZE.WIDE){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) / 2);
			}
		
			//show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.dynamic_hp));
		
		}
	
		//if it is a mirror beam
		else if(light_type == E_LIGHT_TYPES.MIRROR_BEAM){
		
			if(size == E_LIGHT_SIZE.NORMAL){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) * bounce_damage_mod);
			}
			else if (size == E_LIGHT_SIZE.NARROW){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) * bounce_damage_mod * 2);
			}
			else if (size == E_LIGHT_SIZE.WIDE){
				other.dynamic_hp = other.dynamic_hp - ((( intensity*global.player.dynamic_light_intensity_mod) * bounce_damage_mod) / 2);
			}
		
		
			//show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.dynamic_hp));
		
		}
	
		else if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
		
			if(size == E_LIGHT_SIZE.NORMAL){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) * prism_damage_mod);
			}
			else if (size == E_LIGHT_SIZE.NARROW){
				other.dynamic_hp = other.dynamic_hp - ((intensity*global.player.dynamic_light_intensity_mod) * prism_damage_mod * 2);
			}
			else if (size == E_LIGHT_SIZE.WIDE){
				other.dynamic_hp = other.dynamic_hp - (((intensity*global.player.dynamic_light_intensity_mod) * prism_damage_mod) / 2);
			}
		
		
			//show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.dynamic_hp));
		
		}
	
	
	}


}
