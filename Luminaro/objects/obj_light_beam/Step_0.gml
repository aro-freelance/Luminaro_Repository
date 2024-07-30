

if(global.game_state == E_GAME_STATE.PLAYING){

// Inherit the parent event
event_inherited();


#region Set Collision bool for growth


if(place_meeting(x, y, obj_enemy) && is_on){
	
	
	var obj = instance_place(x, y, obj_enemy);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1;
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_mirror) && is_on && light_type != E_LIGHT_TYPES.MIRROR_BEAM){
	
	
	
	var obj = instance_place(x, y, obj_mirror);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	
	is_colliding = true;
}
else if(( place_meeting(x, y, obj_floor)) && is_on){ //place_meeting(x, y, layer_tilemap_get_id("Tiles_Floor")) ||

	
	
	var obj = instance_place(x, y, obj_floor);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	is_colliding = true;
	
	
	

}

else if( (place_meeting(x, y, obj_wall)) && is_on){  //(place_meeting(x, y, layer_tilemap_get_id("Tiles_Walls")) ||
	
	show_debug_message("light step: collide tiles wall");
	
	var obj = instance_place(x, y, obj_wall);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	is_colliding = true;
	
	

}

else if((place_meeting(x, y, obj_ceiling)) && is_on){ //place_meeting(x, y, layer_tilemap_get_id("Tiles_Ceiling")) || 
	
	show_debug_message("light step: collide tiles ceiling");
	
	
	var obj = instance_place(x, y, obj_ceiling);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	is_colliding = true;

	

}

else if(place_meeting(x, y, obj_shadow) && is_on){
	
	show_debug_message("light step: collide shadow");
	
	var obj = instance_place(x, y, obj_shadow);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_projectile_weapon_enemy) && is_on){
	
	show_debug_message("light step: collide bullet");
	
	var obj = instance_place(x, y, obj_projectile_weapon_enemy);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}

else if(is_colliding){
	depth = -9;
	is_colliding = false;
	show_debug_message("light step: stopped colliding");
}

#endregion




#region Grow Beam Over Time

if(is_on){
	growth_deceleration = clamp(growth_deceleration + deceleration_rate , 0, global.player.dynamic_beam_speed/2)
}


if(!is_on){
	image_xscale = min_xscale;
	mask_index = sprite_index;
}


if(image_xscale < (max_xscale*global.player.dynamic_beam_length_mod)){
	if(!is_colliding){
		image_xscale += global.player.dynamic_beam_speed - growth_deceleration;
		mask_index = sprite_index;
	}
}


#endregion


}


