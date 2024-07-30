
if(global.game_state == E_GAME_STATE.PLAYING){


#region init

if(!init){
	init = true;

	player_location_snapshot = [global.player.x, global.player.y];
	
	
	
	distance_to_player = distance_to_object(global.player);
	
	image_angle =  point_direction(array_get(player_location_snapshot, 0), array_get(player_location_snapshot, 1), x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]));
	
	direction = image_angle;
	
	
	is_on = true;
}

#endregion

#region Move Towards Player

if(is_on){
	
	
	//if(bounce_counter < 1){
		move_towards_point( array_get(player_location_snapshot, 0), array_get(player_location_snapshot, 1), movement_speed);
	//}
	
	if(x == array_get(player_location_snapshot, 0) && y == array_get(player_location_snapshot, 1)){
		instance_destroy();
	}
	
}

#endregion


#region Collision with Solid





if(place_meeting(x, y, obj_projectile_weapon_enemy)){
	show_debug_message("collision with projectile");
	var index = ds_list_find_index(owner.projectiles, self);
	ds_list_delete(owner.projectiles, index);
	instance_destroy();	
}

//layer_tilemap_get_id("Tiles_Ceiling"),
if(place_meeting(x, y, [layer_tilemap_get_id("Tiles_Walls"),  layer_tilemap_get_id("Tiles_Floor")])){
	show_debug_message("collision with tiles");
	
	//TODO: handle bouncing

	/* this is not working. make bounce work if there is time. Also turn on 
	if(can_bounce){
		if(bounce_counter < bounce_number){
			bounce_counter++;
			x = xprevious;
			y = yprevious;
			direction = -direction;
		}
	}
	*/
	
	var index = ds_list_find_index(owner.projectiles, self);
	ds_list_delete(owner.projectiles, index);
	instance_destroy();	
	
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