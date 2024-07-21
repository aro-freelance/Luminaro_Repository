/// @description Insert description here
// You can write your code in this editor

if(global.game_state == E_GAME_STATE.PLAYING){

// Inherit the parent event
event_inherited();




#region End Collision

if(place_meeting(x, y, obj_enemy)){
	
	show_debug_message("light step: collide enemy");
	
	var obj = instance_place(x, y, obj_enemy);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1;
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_mirror)){
	
	show_debug_message("light step: collide mirror");
	
	var obj = instance_place(x, y, obj_mirror);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_solid)){
	
	show_debug_message("light step: collide solid");
	var obj = instance_place(x, y, obj_solid);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	show_debug_message("distance = " + string(distance) + ". width = " + string(sprite_get_width(sprite_index)) + ". scale = " + string(image_xscale));
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_shadow)){
	
	show_debug_message("light step: collide shadow");
	
	var obj = instance_place(x, y, obj_shadow);
	var distance = point_distance(x, y, obj.x, obj.y);
	depth = -50;
	image_xscale = 1
	image_xscale = distance / sprite_get_width(sprite_index);
	
	is_colliding = true;
}
else if(place_meeting(x, y, obj_projectile_weapon_enemy)){
	
	show_debug_message("light step: collide bullet");
	
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
	show_debug_message("light step: stopped colliding");
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


