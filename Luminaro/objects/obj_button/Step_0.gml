
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)){

	global.game_state = E_GAME_STATE.PLAYING;
	
	room_goto(rm_level1);
}
