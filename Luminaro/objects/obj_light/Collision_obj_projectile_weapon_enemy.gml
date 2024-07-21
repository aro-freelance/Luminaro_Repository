/// @description destroy hit projectiles

if(global.game_state == E_GAME_STATE.PLAYING){

if(is_on){
	
	show_debug_message("projectile collides with light");

	instance_destroy(other);
}




}