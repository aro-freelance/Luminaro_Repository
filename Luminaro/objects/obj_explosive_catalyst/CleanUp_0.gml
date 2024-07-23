/// @description this has been destroyed. tell the player

global.player.current_spawned_catalysts--;

show_debug_message("catalyst destroyed. current spawned = " + string(global.player.current_spawned_catalysts));