



#region init

if(!init){
	init = true;

	//player_location_snapshot = [global.player.x, global.player.y];
	
	distance_to_player = distance_to_object(obj_player);
	
	sprite_rotation = point_direction(x, y, global.player.x, global.player.y) - 90;
	
	scale_distance_ratio = (distance_to_player + followthrough_distance) / sprite_get_height(sprite_index);
	
	is_on = true;
}

#endregion

#region attach to enemy

x = owner.x;
y = owner.y;

#endregion


#region increase in size and reach towards player

//if not at size to reach player's location
if(y_scale < scale_distance_ratio){
	//show_debug_message("meleeweapon: growing. range = " + string(owner.dynamic_melee_attack_range) + ". distance = " + string(distance_to_object(obj_player)));
	
	//if not touching player
	if(!place_meeting(x, y, obj_player)){
		//increase size
		y_scale += growth_factor;
		image_yscale = y_scale;
		image_angle = sprite_rotation;
		//var _spr = object_get_sprite(object_index);
		//mask_index = _spr;
		//show_debug_message("y scale = " + string(image_yscale));
	}
	
}
else{
	//show_debug_message("meleeweapon: reached max size. destroy self. B: range = " + string(owner.dynamic_melee_attack_range) + ". distance = " + string(distance_to_object(obj_player)));
	destroy_counter++;
	if (destroy_counter >= destroy_delay) instance_destroy();
}

#endregion

#region Deal Damage

/*
if(place_meeting(x + sprite_width, y + (sprite_height * y_scale), obj_player) || place_meeting(global.player.x, global.player.y, self)){
//if(collision_line(x, y, x + sprite_width, y + sprite_height, obj_player, false, true)){
	
	global.player.dynamic_hp = global.player.dynamic_hp - intensity;
	show_debug_message("========================== melee attack hits player. player hp = " + string(global.player.dynamic_hp));
	
	instance_destroy();
}
*/


#endregion
