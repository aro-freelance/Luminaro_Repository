
if(holder != noone){
	if (holder.facing == E_FACING.left){
	    x_offset = -hold_distance;
	} else {
	     x_offset = hold_distance;
	}
	x = holder.x + x_offset;
	y = holder.y - sprite_get_height(holder.sprite_index)/2;
	
	//show_debug_message("lantern x = " + string(x) + ". y = " + string(y));
}



if(can_bounce && (bounce_counter < bounce_number)){
	if(place_meeting(x, y, obj_solid)){
		
		bounce_counter++;
		var surface = instance_place(x, y, obj_solid);
		
		if (direction<surface.direction){
		    direction=direction+(180-(180-(abs(surface.direction-direction)*2)))
		}
		else{
		    direction=direction+(180-(180-(abs((surface.direction+360)-direction)*2)))
		}
	}
}