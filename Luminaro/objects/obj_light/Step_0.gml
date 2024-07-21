
if(global.game_state == E_GAME_STATE.PLAYING){

var spr = object_get_sprite(object_index);
if (sprite_index != spr)
{
    sprite_index = spr;
	mask_index = spr;
}




#region Change Facing Direction

if(holder != noone){
	if(holder == global.player){
		if (holder.facing == E_FACING.left){
		    x_offset = -hold_distance;
		} else {
		     x_offset = hold_distance;
		}
	}
	else{
		x_offset = 0;
	}
		x = holder.x + x_offset;
		y = holder.y - sprite_get_height(holder.sprite_index)/2;
	
		//show_debug_message("lantern x = " + string(x) + ". y = " + string(y));
	
}

#endregion


#region Bounce

if(is_on){
	if(can_bounce && (bounce_counter < bounce_number)){
		if(place_meeting(x, y, obj_mirror)){
			bounce_counter++;
			
			var mirror = instance_place(x, y, obj_mirror);
			
			var point = scr_get_obj_collision_point(x, y, mirror);
			
			show_debug_message("collision with mirror. bounce counter = " + string(bounce_counter));
			
			if(mirror.beam == noone){
				
				show_debug_message("light step: bounce: create beam");
				
				//make the beam
				//mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
				if(array_length(point) == 2){
					mirror.beam = instance_create_layer(array_get(point, 0), array_get(point, 1), "Weapons", obj_light_beam);
					mirror.beam.holder = mirror;
					mirror.beam.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
				}
			}
			else{
				show_debug_message("light step: bounce: move beam. x = " + string(mirror.beam.x) + ". y = " + string(mirror.beam.y) + ". point x =" + string(array_get(point, 0)) + ". point y = " + string(array_get(point, 1)) );
				mirror.beam.x = array_get(point, 0);
				mirror.beam.y = array_get(point, 1);
			}
		
		
		/*
		
			if(mirror.beam == noone){
				//make the beam
				mirror.beam = instance_create_layer(mirror.x, mirror.y, "Weapons", obj_light_beam);
				mirror.beam.image_angle = global.player.beam.image_angle - 90;
				mirror.beam.is_on = true;
			}
			else{
				mirror.beam.image_angle = global.player.beam.image_angle - 90;
				show_debug_message("beam exists. angle = " + string(mirror.beam.image_angle));
			}
		*/
			//#YELSA YOU ARE HERE
			// current plan is make a new beam 
			// set its angle be a reflection of the angle the original beam hit the mirror.
			//set its x scale ? or have it be the same length as the original?
			// in general should the x scale of the beam go up? could start it short and have it go up to a certain length?
			// could also have it's alpha fade at the end? and potency fade based on distance from player?
		
			//also when done here... the enemy projectile collision with solid obj needs bounce functionality.
			//and beam collision with solid obj should hide the rest of the beam after collision? for this use draw_sprite_part
		
		
			/*
			var surface = instance_place(x, y, obj_mirror);
		
			if (direction<surface.direction){
			    direction=direction+(180-(180-(abs(surface.direction-direction)*2)))
			}
			else{
			    direction=direction+(180-(180-(abs((surface.direction+360)-direction)*2)))
			}
			*/
		
		}
	}
}
	

//reset the bounce counter if not in contact with a mirror
if(bounce_counter > 0){
	if(!place_meeting(x, y, obj_mirror)){
		bounce_counter = 0;
		show_debug_message("END collision with mirror. reset bounce counter");
	}
}

#endregion



}