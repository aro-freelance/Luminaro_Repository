

if(is_on){
	
	if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
		if(size == E_LIGHT_SIZE.NARROW){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale/2, image_yscale/2, image_angle, image_blend, image_alpha);
		}
		else if (size == E_LIGHT_SIZE.WIDE){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*2, image_yscale*2, image_angle, image_blend, image_alpha);
		}
		else if (size == E_LIGHT_SIZE.NORMAL){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		}
	}
	
	
	
	if(light_type == E_LIGHT_TYPES.PLAYER_BEAM || light_type == E_LIGHT_TYPES.MIRROR_BEAM || light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
		if(size == E_LIGHT_SIZE.NARROW){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale/4, image_angle, image_blend, image_alpha);
		}
		else if (size == E_LIGHT_SIZE.WIDE){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale*3, image_angle, image_blend, image_alpha);
		}
		else if (size == E_LIGHT_SIZE.NORMAL){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
		}
	}
	
}

draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, true);