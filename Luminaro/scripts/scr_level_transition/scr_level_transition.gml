
//transition the player to the next room

function scr_level_transition(level){

global.game_state = E_GAME_STATE.LEVEL_TRANSITION;

	//if it is a level
	if(level < array_length(global.levels)){		
		var destination_room = global.levels[level];	
		
		//display end story
		var message_box = instance_create_layer(global.dg_width/2, global.dg_height/2, "UI", obj_message);
		message_box.text_array = global.game_obj.current_end_story;
		
		global.player.init = false;
		
	
	}
	//else go to the win screen
	else{
		var destination_room = rm_win_screen;
	
		//display end story
		var message_box = instance_create_layer(global.dg_width/2, global.dg_height/2, "UI", obj_message);
		message_box.text_array = global.game_obj.win_story;

		global.game_state = E_GAME_STATE.MAIN_MENU;
	
	}

	message_box.x_scale = .5;
	message_box.y_scale = .5;
	message_box.transition_room = destination_room;
	message_box.is_transition = true;


}