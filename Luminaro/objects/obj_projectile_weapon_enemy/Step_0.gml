
if(global.game_state == E_GAME_STATE.PLAYING){


#region init

if(!init){
	init = true;

	player_location_snapshot = [global.player.x, global.player.y];
	
	distance_to_player = distance_to_object(obj_player);
	
	image_angle = point_direction(x, y, global.player.x, global.player.y) - 90;
	
	//scale_distance_ratio = distance_to_player / sprite_get_height(sprite_index);
	
	is_on = true;
}

#endregion

#region Move Towards Player

if(is_on){
	
	if(bounce_counter < 1){
		move_towards_point(array_get(player_location_snapshot, 0), array_get(player_location_snapshot, 1), movement_speed);
	}
	
}

#endregion


#region Collision with Solid

if(place_meeting(x, y, obj_solid)){
	
	//destroy on impact if it cannot bounce
	if(!can_bounce){
		var index = ds_list_find_index(owner.projectiles, self);
		ds_list_delete(owner.projectiles, index);
		instance_destroy();
	}
	//bounce
	else{
		//TODO: handle bouncing
	}
}


#endregion

#region Deal Damage

if(place_meeting(x, y, obj_player)){
	global.player.dynamic_hp = global.player.dynamic_hp - intensity;
	show_debug_message("projectile attack hits player. player hp = " + string(global.player.dynamic_hp));
	
	var index = ds_list_find_index(owner.projectiles, self);
	ds_list_delete(owner.projectiles, index);
	instance_destroy();
}

#endregion



}