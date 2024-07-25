
if (mouse_check_button_pressed(mb_left) && position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id)){

	var message_box = instance_create_layer(display_width/2, display_height/2, "UI", obj_message);
	
	message_box.is_fullscreen = is_fullscreen;
	message_box.text_array = text_array;
	message_box.x_scale = x_scale;
	message_box.y_scale = y_scale;
	message_box.alpha = alpha;
	message_box.background_sprite = background_sprite;
	message_box.text_color = text_color;
	
	//TODO: need more logic to handle larger sizes and different alignments. spacing and start position need to be updated based on these values
	//message_box.text_halign = text_halign;
	//message_box.text_valign = text_valign;
	//message_box.text_font = text_font;
	
}