
if(delay_counter < delay){
	delay_counter++;
}


if(is_active){
	subimage = 0;
}
else{
	subimage = 1;
}

if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){

	if(is_active && delay_counter >= delay){
		global.game_state = E_GAME_STATE.MAIN_MENU;
		room_goto(destination_room);
	}
}
