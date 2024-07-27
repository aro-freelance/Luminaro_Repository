/// @description Insert description here
// You can write your code in this editor

if(global.game_state == E_GAME_STATE.PLAYING){

// Inherit the parent event
event_inherited();



#region Set Collision bool for growth


if(place_meeting(x, y, obj_enemy) && is_on){
	
	//show_debug_message("light step: collide enemy");
	
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
	
	//show_debug_message("light step: collide mirror. xscale = " + string(image_xscale));
	
	is_colliding = true;
}
else if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Floor")) && is_on){
	
	//show_debug_message("light step: collide tiles");
	
	//var obj = instance_place(x, y, layer_tilemap_get_id("Tiles"));
	//var distance = point_distance(x, y, obj.x, obj.y);
	
	var average_collision_point = scr_get_tm_collision_point(x, y, "Tiles_Floor");
	
	//if((array_get(average_collision_point, 0) == 0 && array_get(average_collision_point, 1) != 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) == 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) != 0)   ){
	if(array_length(average_collision_point) == 2){
		var distance = point_distance(x, y, array_get(average_collision_point, 0), array_get(average_collision_point, 1));
	
		//show_debug_message("light beam: x = " + string(x) + ". y = " + string(y) + ". cpx = " + string( array_get(average_collision_point, 0)) + ". cpy = " + string( array_get(average_collision_point, 1)));
	
		depth = -50;
		image_xscale = 1
		image_xscale = distance / sprite_get_width(sprite_index);
		
		//show_debug_message("distance = " + string(distance) + ". width = " + string(sprite_get_width(sprite_index)) + ". scale = " + string(image_xscale));
	
		is_colliding = true;
	}
}

else if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Walls")) && is_on){
	
	//show_debug_message("light step: collide tiles");
	
	//var obj = instance_place(x, y, layer_tilemap_get_id("Tiles"));
	//var distance = point_distance(x, y, obj.x, obj.y);
	
	var average_collision_point = scr_get_tm_collision_point(x, y, "Tiles_Walls");
	
	//if((array_get(average_collision_point, 0) == 0 && array_get(average_collision_point, 1) != 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) == 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) != 0)   ){
	if(array_length(average_collision_point) == 2){
		var distance = point_distance(x, y, array_get(average_collision_point, 0), array_get(average_collision_point, 1));
	
		//show_debug_message("light beam: x = " + string(x) + ". y = " + string(y) + ". cpx = " + string( array_get(average_collision_point, 0)) + ". cpy = " + string( array_get(average_collision_point, 1)));
	
		depth = -50;
		image_xscale = 1
		image_xscale = distance / sprite_get_width(sprite_index);
		
		//show_debug_message("distance = " + string(distance) + ". width = " + string(sprite_get_width(sprite_index)) + ". scale = " + string(image_xscale));
	
		is_colliding = true;
	}
}

else if(place_meeting(x, y, layer_tilemap_get_id("Tiles_Ceiling")) && is_on){
	
	//show_debug_message("light step: collide tiles");
	
	//var obj = instance_place(x, y, layer_tilemap_get_id("Tiles"));
	//var distance = point_distance(x, y, obj.x, obj.y);
	
	var average_collision_point = scr_get_tm_collision_point(x, y, "Tiles_Ceiling");
	
	//if((array_get(average_collision_point, 0) == 0 && array_get(average_collision_point, 1) != 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) == 0) || (array_get(average_collision_point, 0) != 0 && array_get(average_collision_point, 1) != 0)   ){
	if(array_length(average_collision_point) == 2){
		var distance = point_distance(x, y, array_get(average_collision_point, 0), array_get(average_collision_point, 1));
	
		//show_debug_message("light beam: x = " + string(x) + ". y = " + string(y) + ". cpx = " + string( array_get(average_collision_point, 0)) + ". cpy = " + string( array_get(average_collision_point, 1)));
	
		depth = -50;
		image_xscale = 1
		image_xscale = distance / sprite_get_width(sprite_index);
		
		//show_debug_message("distance = " + string(distance) + ". width = " + string(sprite_get_width(sprite_index)) + ". scale = " + string(image_xscale));
	
		is_colliding = true;
	}
}

else if(place_meeting(x, y, obj_shadow) && is_on){
	
	//show_debug_message("light step: collide shadow");
	
	var obj = instance_place(x, y, obj_shadow);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_projectile_weapon_enemy) && is_on){
	
	//show_debug_message("light step: collide bullet");
	
	var obj = instance_place(x, y, obj_projectile_weapon_enemy);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if (is_colliding){
	depth = -9;
	is_colliding = false;
	//show_debug_message("light step: stopped colliding");
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


