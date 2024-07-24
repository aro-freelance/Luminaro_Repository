
if(global.player_menu.selected_item_type_1 != -1 && global.player_menu.selected_item_type_2 != -1){
	is_active = true;
}



if(is_active){
	subimage = 0;
}
else{
	subimage = 1;
}


if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){

	if(is_active){
		scr_combine_items(global.player_menu.selected_item_type_1, global.player_menu.selected_item_type_2);
	}
}