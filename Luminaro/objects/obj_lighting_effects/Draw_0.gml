 var camera_width = camera_get_view_width(view_camera[0]);
 var camera_height = camera_get_view_height(view_camera[0]);



//if there is no drawing area, make one
if (!surface_exists(surface)){
   
	
	//create the drawing area
    surface = surface_create(camera_width, camera_height);
    surface_set_target(surface);
    draw_set_colour(c_black);
	
	//clear the drawing area
    draw_set_alpha(0);
    draw_rectangle(0, 0, camera_width, camera_height, false);
    surface_reset_target();
}
//there is a surface for drawing
else if (surface_exists(surface)) {
	var cx = camera_get_view_x(view_camera[0]);
	var cy = camera_get_view_y(view_camera[0]);
	
	surface_set_target(surface);
	draw_set_color(c_black);
	draw_set_alpha(global.darkness_level);
	draw_rectangle(0, 0, camera_width, camera_height, false);
	gpu_set_blendmode(bm_subtract);
	

	
	with (obj_light){
		if(is_on){
			var sw = sprite_get_width(sprite_index) / 2;
			var sh = sprite_get_height(sprite_index) / 2;
			
			if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
				draw_sprite_ext(spr_light_effect, 0, x -cx, y -cy, image_xscale, image_yscale, image_angle, c_white, 1);	
			}
			else{
				draw_sprite_ext(spr_light_beam_effect, 0, x - cx, y -cy, 1.01*image_xscale, 1.5*image_yscale, image_angle, c_white, 1);			   
			}
		}
	}
	
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
	surface_reset_target();
	draw_surface(surface, cx, cy);
}