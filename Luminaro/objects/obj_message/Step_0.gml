
if(!init){
	init = true;
	
	#region handle pause
	instance_deactivate_all(true);
	instance_activate_object(self);
	instance_activate_object(obj_lighting_effects);
	#endregion
	
	#region update background_width and background_height
	
	//if there is a different background input, update the background w and h variables
	background_width = sprite_get_width(background_sprite);
	background_height = sprite_get_height(background_sprite);
	
	var fullscreen_x_scale = display_width / background_width;
	var fullscreen_y_scale = display_height / background_height;
	
	if(is_fullscreen){
		x_scale = fullscreen_x_scale;
		y_scale = fullscreen_y_scale;
	}

	if(x_scale > fullscreen_x_scale) x_scale = fullscreen_x_scale;
	if(y_scale > fullscreen_y_scale) y_scale = fullscreen_y_scale;
	
	background_width *= x_scale;
	background_height *= y_scale;
	
	#endregion

}


if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_left) ){
	
	if(ta_counter < (array_length(text_array) -1)){
		ta_counter++;
	}
	else instance_destroy();
}
