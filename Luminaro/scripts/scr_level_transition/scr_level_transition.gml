
//transition the player to the next room

function scr_level_transition(level){

global.game_state = E_GAME_STATE.LEVEL_TRANSITION;

	//if it is a level
	if(level < array_length(global.levels)){		
		var destination_room = global.levels[level];	
	
		show_debug_message("scr level transition: End of level. moving to next. level = " + string(level));
	
		//TODO: display end of level message when it closes move the player to the next room.
		var message_box = instance_create_layer(display_get_gui_width()/2, display_get_gui_height()/2, "UI", obj_message);
		message_box.text_array = obj_game.current_end_story;
		
		global.game_state = E_GAME_STATE.PLAYING;
	
	}
	//else go to the win screen
	else{
		var destination_room = rm_win_screen;
	
		show_debug_message("scr level transition: End of levels. TODO: setup functionality for winning the game here. ");
		//TODO: for the jam display a message saying that is the end of the jam demo and return player to main menu... 
		var message_box = instance_create_layer(display_get_gui_width()/2, display_get_gui_height()/2, "UI", obj_message);
		message_box.text_array = obj_game.win_story;

		global.game_state = E_GAME_STATE.MAIN_MENU;
	
	}

	message_box.x_scale = .5;
	message_box.y_scale = .5;
	message_box.transition_room = destination_room;
	message_box.is_transition = true;


}