/// @description Insert description here
// You can write your code in this editor

if(global.game_state == E_GAME_STATE.PLAYING){

global.player.dynamic_hp = global.player.dynamic_hp - intensity;
show_debug_message("========================== melee attack hits player. player hp = " + string(global.player.dynamic_hp));
	
instance_destroy();

}