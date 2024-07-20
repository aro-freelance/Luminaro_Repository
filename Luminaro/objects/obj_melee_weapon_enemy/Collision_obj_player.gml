/// @description Insert description here
// You can write your code in this editor

global.player.dynamic_hp = global.player.dynamic_hp - intensity;
show_debug_message("========================== melee attack hits player. player hp = " + string(global.player.dynamic_hp));
	
instance_destroy();