if(os_browser != browser_not_a_browser){
	var _dw = 99*browser_width/100;
	var _dh = 99*browser_height/100;
	
	display_set_gui_size(_dw, _dh);
	//window_set_size(_dw, _dh);
	camera_set_view_size(view_camera[0], _dw, _dh);
	surface_resize(application_surface, _dw, _dh);
	window_set_rectangle(0, 0, _dw, _dh);
	
	display_set_gui_size(_dw, _dh);
	global.dg_width = display_get_width();
	global.dg_height = display_get_height();
}




spawn_point = [global.dg_width/2, global.dg_height/2];	


if(global.player == noone) {
	global.player = instance_create_layer(array_get(spawn_point, 0), array_get(spawn_point, 1), "Actors", obj_player);
}
else{
	global.player.x = array_get(spawn_point, 0)
	global.player.y = array_get(spawn_point, 1);
	
	scr_reset_player();
	
	
	global.game_state = E_GAME_STATE.PLAYING;
}




//TODO: set saved stats to player

global.lighting_effects = instance_create_layer(0, 0, "Effects", obj_lighting_effects);


obj_intro_story = instance_create_layer(global.dg_width/2, global.dg_height/2, "UI", obj_message);
obj_intro_story.is_fullscreen = true;

obj_intro_story.text_array = obj_game.level_2_begin_story;

obj_game.current_boss_story = obj_game.level_2_boss_story;
obj_game.current_end_story = obj_game.level_2_end_story;


















