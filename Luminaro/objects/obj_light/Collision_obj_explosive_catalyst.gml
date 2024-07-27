/// @description obj_light collision with obj_explosive_catalyst


if(global.game_state == E_GAME_STATE.PLAYING){

	//if the light is turned on
	if(is_on){
		if(light_type != E_LIGHT_TYPES.PLAYER_LANTERN){
			other.damage = (intensity*global.player.dynamic_light_intensity_mod) * other.intensity_modifier;
			other.is_exploding = true;
		}
	}
}
