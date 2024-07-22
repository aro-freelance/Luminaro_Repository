
if(global.game_state == E_GAME_STATE.PLAYING){

var spr = object_get_sprite(object_index);
if (sprite_index != spr)
{
    sprite_index = spr;
	mask_index = spr;
}


#region Attach Beam and Change Facing Direction

if(light_type != E_LIGHT_TYPES.MIRROR_BEAM){
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
	
		//attach beam
		x = holder.x + x_offset;
		if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN) y = holder.y - sprite_get_height(holder.sprite_index)/2;
		else y = holder.y - global.player.beam_holding_height;
	
	
	}
}

#endregion


#region Initial Mirror Bounce



if(is_on && can_bounce){
		var max_length = sprite_get_width(sprite_index) * image_xscale;
		//show_debug_message("light step: bounce: max length = " + string(max_length));
		
		
		for (var i = 0; i < max_length; i++ ) {
			xEnd = x + lengthdir_x(i, image_angle);
			yEnd = y + lengthdir_y(i, image_angle);
			
			//if(i = (max_length-1)) show_debug_message("obj_light step: maxlength xend = " + string(xEnd) + ". yend = " + string(yEnd));
		
			 if (collision_point(xEnd, yEnd, obj_mirror, 0, 0 ) ) {
				 
				var mirror = scr_get_hit_mirror(self);
				 
				if(mirror != noone){
					
					 var mirror_beam_angle = scr_get_mirror_beam_angle(self, mirror);
				 
					  if(bounce_counter < bounce_number){
						bounce_counter++;
					
					
					
						if(mirror.beam == noone) mirror.beam = instance_create_layer(xEnd, yEnd, "Weapons", obj_light_beam);
						mirror.beam.holder = self;
						mirror.beam.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
						mirror.beam.is_on = true;
						mirror.beam.can_bounce = false;
						mirror.beam.image_angle = mirror_beam_angle;
					
				
					 }
					 //not a new bounce, if there are current beams update them
					 else{
					 
					 
						 #region Update Bounce Beams
						 
						 if(mirror.beam != noone){
							mirror.beam.image_angle = mirror_beam_angle;
							mirror.beam.x = xEnd;
							mirror.beam.y = yEnd;
						 }


						#endregion
					 
					 
					 }
					 
				 
				 }
		}
		
	}
}

	

//reset the bounce counter if not in contact with a mirror
if(bounce_counter > 0){
	if(!is_on){
		bounce_counter = 0;
		//show_debug_message("END collision with mirror. reset bounce counter");
	}
}

#endregion









}