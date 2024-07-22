

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
			
			
			/*
			
			//top left
			if(bbox_left < holder.bbox_left && bbox_bottom < holder.bbox_bottom){
				show_debug_message("top left");
				draw_circle_color( bbox_left , bbox_top , 50, c_red, c_red, false);
			}
			//top right
			if(bbox_right > holder.bbox_right && bbox_bottom < holder.bbox_bottom){
				show_debug_message("top right");
				draw_circle_color(bbox_right , bbox_top , 50, c_red, c_red, false);
			}
			//bottom left
			if(bbox_left < holder.bbox_left && bbox_top > holder.bbox_top){
				show_debug_message("bottom left");
				draw_circle_color(bbox_left , bbox_bottom , 50, c_red, c_red, false);
			}
			//bottom right
			if(bbox_right > holder.bbox_right && bbox_top > holder.bbox_top){
				show_debug_message("bottom right");
				draw_circle_color( bbox_right , bbox_bottom , 50, c_red, c_red, false);
			}
			*/
			
		}
	}
	
}

draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, true);