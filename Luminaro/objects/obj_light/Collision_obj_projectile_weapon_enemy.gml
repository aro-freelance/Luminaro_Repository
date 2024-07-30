/// @description obj_light collision with enemy projectile

if(global.game_state == E_GAME_STATE.PLAYING){

if(is_on && light_type != E_LIGHT_TYPES.PLAYER_LANTERN){
	

	instance_destroy(other);
}




}