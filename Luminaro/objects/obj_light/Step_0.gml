
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
		if(holder.id == global.player){
			if (holder.facing == E_FACING.left){
			    x_offset = -hold_distance;
				y_offset = -10;
			} else {
			    x_offset = hold_distance;
				y_offset = 0;
			}
		}
		else{
			x_offset = 0;
		}
	
		//attach beam
		
		if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
			x = holder.x + x_offset;
			y = holder.y + y_offset - sprite_get_height(holder.sprite_index)/2;
		}
		else{
			x = holder.x + 1.34*x_offset;
			y = holder.y + y_offset - global.player.beam_holding_height;
		}
	
	
	}
}

#endregion


#region Initial Mirror Bounce



if(is_on && can_bounce){
		var max_length = sprite_get_width(sprite_index) * image_xscale;
		
		
		for (var i = 0; i < max_length; i++ ) {
			xEnd = x + lengthdir_x(i, image_angle);
			yEnd = y + lengthdir_y(i, image_angle);
			
		
			 if (collision_point(xEnd, yEnd, obj_mirror, 0, 0 ) ) {
				
				var mirror = collision_point(xEnd, yEnd, obj_mirror, 0, 0 );
				
				 
				if(mirror != noone){
					
					mirror.light_collision = true;
					
					var mirror_beam_angle = scr_get_mirror_beam_angle(self, mirror);
				
					
					
					if(mirror.beam == noone){
						show_debug_message("obj light: create mirror beam");
						mirror.beam = instance_create_layer(xEnd, yEnd, "Weapons", obj_light_beam);
						mirror.beam.holder = self;
						mirror.beam.light_type = E_LIGHT_TYPES.MIRROR_BEAM;
						mirror.beam.is_on = true;
						mirror.beam.can_bounce = false;
						mirror.beam.image_angle = mirror_beam_angle;
					}
					else{
						mirror.beam.image_angle = mirror_beam_angle;
						mirror.beam.x = xEnd;
						mirror.beam.y = yEnd;
					}
					
				 
				 }
		}
		
	}
}

	



#endregion


#region Set Lantern Size

if(light_type == E_LIGHT_TYPES.PLAYER_LANTERN){
	if(is_on){
		if(image_xscale != global.player.dynamic_lantern_size_mod) image_xscale = global.player.dynamic_lantern_size_mod;
		if(image_yscale != global.player.dynamic_lantern_size_mod) image_yscale = global.player.dynamic_lantern_size_mod;
	}
}


#endregion



}