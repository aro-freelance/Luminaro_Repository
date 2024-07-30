
if(global.game_state == E_GAME_STATE.PLAYING){
	if(owner != noone){
		if(owner.is_on){

			if(!init){
			
				init = true;
				
				x = owner.x;
				y = owner.y;
			
			/*
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
						move_towards_point(x_target, y_target, 20);
					}
					else{
						x = owner.x;
						y = owner.y;
					}
	
				#endregion
				
				*/
				
			}
			
	


			#region Move


				if(owner.image_xscale < (owner.max_xscale*global.player.dynamic_beam_length_mod)){
					
					
					
					var x_delta = lengthdir_x(global.player.sprite_width + global.player.dynamic_beam_speed - owner.growth_deceleration, owner.image_angle) //- sprite_width/2;
					var y_delta = lengthdir_y(global.player.sprite_height, owner.image_angle) //- sprite_height/2;
			


					if(!place_meeting(x + x_delta, y + y_delta, [layer_tilemap_get_id("Tiles_Floor"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Walls")] )){
				
						is_colliding = false;
				
						//move_towards_point(x_delta, y_delta, 20);
						
						x = x + x_delta;
						y = y + y_delta;
				
						show_debug_message("beam tip step: x = " + string(x) + ". y = " + string(y));
						
						
				
					}
					else{
						is_colliding = true;
					}
				}
				


			#endregion

		/*
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
			*/

		}
		else{
			//show_debug_message("owner off " + string(owner.is_on));
			x = owner.x;
			y = owner.y;
			//instance_destroy();
		}
	}
}

