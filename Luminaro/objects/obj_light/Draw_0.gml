
if(is_on){
	
	if(type == E_LIGHT_TYPES.LANTERN){
		if(size == E_LIGHT_SIZE.NARROW){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale/2, sprite_y_scale/2, sprite_rotation, sprite_color, sprite_alpha);
		}
		else if (size == E_LIGHT_SIZE.WIDE){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale * 2, sprite_y_scale * 2, sprite_rotation, sprite_color, sprite_alpha);
		}
		else if (size == E_LIGHT_SIZE.NORMAL){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale, sprite_y_scale, sprite_rotation, sprite_color, sprite_alpha);
		}
	}
	
	
	
	if(type == E_LIGHT_TYPES.BEAM){
		if(size == E_LIGHT_SIZE.NARROW){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale, sprite_y_scale/4, sprite_rotation, sprite_color, sprite_alpha);
		}
		else if (size == E_LIGHT_SIZE.WIDE){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale, sprite_y_scale * 3, sprite_rotation, sprite_color, sprite_alpha);
		}
		else if (size == E_LIGHT_SIZE.NORMAL){
			draw_sprite_ext(sprite_index, sprite_subimage, x, y, sprite_x_scale, sprite_y_scale, sprite_rotation, sprite_color, sprite_alpha);
		}
	}
	
	
	
}
