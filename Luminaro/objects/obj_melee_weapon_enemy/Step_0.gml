



#region init

if(!init){
	init = true;

	//player_location_snapshot = [global.player.x, global.player.y];
	
	distance_to_player = distance_to_object(obj_player);
	
	sprite_rotation = point_direction(x, y, global.player.x, global.player.y) - 90;
	
	//scale_distance_ratio = distance_to_player / sprite_get_height(sprite_index);
	
	is_on = true;
}

#endregion

#region attach to enemy

x = owner.x;
y = owner.y;

#endregion


#region increase in size and reach towards player

//if not at size to reach player's location
if(sprite_height < owner.dynamic_melee_attack_range){
	
	//if not touching player
	if(!place_meeting(x, y, obj_player)){
		//increase size
		y_scale += growth_factor;
	}
	
}
else{
	instance_destroy();
}

#endregion

#region Deal Damage

if(place_meeting(x, y, obj_player)){
	global.player.dynamic_hp = global.player.dynamic_hp - intensity;
	show_debug_message("melee attack hits player. player hp = " + string(global.player.dynamic_hp));
	
	instance_destroy();
}

#endregion
