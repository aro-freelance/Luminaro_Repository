/// @description Insert description here
// You can write your code in this editor


if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){

	show_debug_message("inventory button clicked. item_type = " + string(item_type));
	
	if(global.player_menu != noone && !is_clicked) {
	
		if(global.player_menu.selected_item_type_1 == -1){
			is_clicked = true;
			global.player_menu.selected_item_type_1 = item_type;
		}
		else {
			is_clicked = true;
			global.player_menu.selected_item_type_2 = item_type;
		}
	}
	
}


if (position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){

	tooltip_on = true;
	
}
else if (tooltip_on) tooltip_on = false;