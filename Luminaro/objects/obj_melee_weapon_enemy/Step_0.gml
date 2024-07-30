
if(global.game_state == E_GAME_STATE.PLAYING){


#region init

if(!init){
	init = true;

	//player_location_snapshot = [global.player.x, global.player.y];
	
	distance_to_player = distance_to_object(obj_player);
	
	image_angle = point_direction(x, y, global.player.x, global.player.y) - 90;
	
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
if(image_yscale < scale_distance_ratio){
	//show_debug_message("meleeweapon: growing. range = " + string(owner.dynamic_melee_attack_range) + ". distance = " + string(distance_to_object(obj_player)));
	
	//if not touching player
	if(!place_meeting(x, y, obj_player)){
		//increase size
		image_yscale += growth_factor;
	}
	
}
else{
	destroy_counter++;
	if (destroy_counter >= destroy_delay) instance_destroy();
}

#endregion




}