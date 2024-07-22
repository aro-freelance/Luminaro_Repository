/// @description Insert description here
// You can write your code in this editor

if(global.game_state == E_GAME_STATE.PLAYING){

// Inherit the parent event
event_inherited();




if(is_on){

	//top left
	if(bbox_left < holder.bbox_left && bbox_bottom < holder.bbox_bottom){
		//show_debug_message("top left");
		var point = [bbox_left, bbox_top];
	}
	//top right
	else if(bbox_right > holder.bbox_right && bbox_bottom < holder.bbox_bottom){
		//show_debug_message("top right");
		var point = [bbox_right , bbox_top];
	}
	//bottom left
	else if(bbox_left < holder.bbox_left && bbox_top > holder.bbox_top){
		//show_debug_message("bottom left");
		var point = [bbox_left , bbox_bottom];
	}
	//bottom right
	else if(bbox_right > holder.bbox_right && bbox_top > holder.bbox_top){
		//show_debug_message("bottom right");
		var point = [bbox_right , bbox_bottom];
	}
	else{
		var point = [];
	}

	if(array_length(point) == 2){
		var collision_obj = collision_line(x, y, array_get(point, 0), array_get(point, 1), id, true, true);
	
		if(collision_obj != noone){
			show_debug_message("collision obj = " + string(collision_obj));
		}
	}

}




#region Collision

if(place_meeting(x, y, obj_enemy) && is_on){
	
	//show_debug_message("light step: collide enemy");
	
	var obj = instance_place(x, y, obj_enemy);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1;
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_mirror) && is_on){
	
	
	
	var obj = instance_place(x, y, obj_mirror);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	//show_debug_message("light step: collide mirror. xscale = " + string(image_xscale));
	
	is_colliding = true;
}
else if(place_meeting(x, y, layer_tilemap_get_id("Tiles")) && is_on){
	
	//show_debug_message("light step: collide tiles");
	
	//var obj = instance_place(x, y, layer_tilemap_get_id("Tiles"));
	//var distance = point_distance(x, y, obj.x, obj.y);
	
	var average_collision_point = scr_get_tm_collision_point(x, y, "Tiles");
	
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


if(!is_on){
	image_xscale = min_xscale;
	mask_index = sprite_index;
}

if(image_xscale < max_xscale){
	if(!is_colliding){
		image_xscale += xscale_growth;
		mask_index = sprite_index;
	}
}




#endregion



}


