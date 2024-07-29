
if(owner != noone){
	if(owner.is_on){

		#region attach to end of beam
	
			var distance = point_distance( 
			owner.x,
			owner.y, 
			owner.x + (sprite_get_width(owner.sprite_index) * owner.image_xscale), 
			owner.y
			);
	
			var x_target = owner.x + lengthdir_x(distance, owner.image_angle) - sprite_width/2;
			var y_target = owner.y + lengthdir_y(distance, owner.image_angle) - sprite_height/2;
			
			if(x != x_target && y != y_target){
				move_towards_point(x_target, y_target, 10);
			}
			else{
				x = owner.x;
				y = owner.y;
			}
			
	
		#endregion


		if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Floor"))){
			is_colliding = true;
		
			show_debug_message("tip collide floor");
		}

		else if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Ceiling"))){
			is_colliding = true;
			show_debug_message("tip collide ceiling");
		}
	
		else if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Walls"))){
			is_colliding = true;
			show_debug_message("tip collide walls");
		}
		else {
			is_colliding = false;
		}

	}
	else{
		show_debug_message("owner off");
		//instance_destroy();
	}
}


