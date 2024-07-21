/// @description destroy hit projectiles

if(global.game_state == E_GAME_STATE.PLAYING){

if(is_on && light_type != E_LIGHT_TYPES.PLAYER_LANTERN){
	
	show_debug_message("projectile collides with light");

	instance_destroy(other);
}




}