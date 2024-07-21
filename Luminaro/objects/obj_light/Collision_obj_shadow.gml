/// @description Insert description here
// You can write your code in this editor

if(global.game_state == E_GAME_STATE.PLAYING){

//if the light is turned on
if(is_on){
	
	//if it is a lantern
	if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
	
		
		other.hp = other.hp - intensity;
		show_debug_message("obj_light collision obj_enemy: enemy collision with lantern. hp = " + string(other.hp));

	}

	//if it is a player beam
	else if(light_type == E_LIGHT_TYPES.PLAYER_BEAM){
		
		
	
		if(size = E_LIGHT_SIZE.NORMAL){
			other.hp = other.hp - (intensity + (global.player.on_timer/global.player.battery) );
		}
		else if (size = E_LIGHT_SIZE.NARROW){
			other.hp = other.hp - (intensity * (global.player.on_timer/global.player.battery) * 2);
		}
		else if (size = E_LIGHT_SIZE.WIDE){
			other.hp = other.hp - ((intensity * (global.player.on_timer/global.player.battery)) / 2);
		}
		
		show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.hp));
		
	}
	
	//if it is a mirror beam
	else if(light_type == E_LIGHT_TYPES.MIRROR_BEAM){
		
		if(size = E_LIGHT_SIZE.NORMAL){
			other.hp = other.hp - (intensity * (global.player.on_timer/global.player.battery) * bounce_damage_mod);
		}
		else if (size = E_LIGHT_SIZE.NARROW){
			other.hp = other.hp - (intensity * (global.player.on_timer/global.player.battery) * bounce_damage_mod * 2);
		}
		else if (size = E_LIGHT_SIZE.WIDE){
			other.hp = other.hp - ((intensity * (global.player.on_timer/global.player.battery) * bounce_damage_mod) / 2);
		}
		
		
		show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.hp));
		
	}
	
	else if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
		
		if(size = E_LIGHT_SIZE.NORMAL){
			other.hp = other.hp - (intensity * (global.player.on_timer/global.player.battery) * prism_damage_mod);
		}
		else if (size = E_LIGHT_SIZE.NARROW){
			other.hp = other.hp - (intensity * (global.player.on_timer/global.player.battery) * prism_damage_mod * 2);
		}
		else if (size = E_LIGHT_SIZE.WIDE){
			other.hp = other.hp - ((intensity * (global.player.on_timer/global.player.battery) * prism_damage_mod) / 2);
		}
		
		
		show_debug_message("obj_light collision obj_enemy: enemy collision with light beam. hp = " + string(other.hp));
		
	}
	
	
}

}