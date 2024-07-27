/*
if (browser_width != width || browser_height != height)
{
width = browser_width-5;
height = browser_height-5;
window_set_size(width, height);
}
*/



spawn_point = [display_get_gui_width()/2, display_get_gui_height()/2];	


if(global.player == noone) global.player = instance_create_layer(array_get(spawn_point, 0), array_get(spawn_point, 1), "Actors", obj_player);
else{
	global.player.x = array_get(spawn_point, 0)
	global.player.y = array_get(spawn_point, 1);
	
	scr_reset_player();
	
	global.game_state = E_GAME_STATE.PLAYING;
}



//TODO: set saved stats to player

global.lighting_effects = instance_create_layer(0, 0, "Effects", obj_lighting_effects);


obj_intro_story = instance_create_layer(display_get_gui_width()/2, display_get_gui_height()/2, "UI", obj_message);
obj_intro_story.is_fullscreen = true;


obj_intro_story.text_array = obj_game.level_1_begin_story;

obj_game.current_boss_story = obj_game.level_1_boss_story;
obj_game.current_end_story = obj_game.level_1_end_story;






















