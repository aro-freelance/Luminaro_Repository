
if(global.game_state == E_GAME_STATE.PLAYING){


#region init

if(!init){
	init = true;

	//player_location_snapshot = [global.player.x - camera_get_view_x(view_camera[0]) , global.player.y - camera_get_view_y(view_camera[0]) - sprite_get_height(global.player.sprite_index)/2 ] ;
	
	player_location_snapshot = [global.player.x, global.player.y];
	
	
	
	distance_to_player = distance_to_object(global.player);
	
	image_angle =  point_direction(array_get(player_location_snapshot, 0), array_get(player_location_snapshot, 1), x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]));
	
	direction = image_angle;
	
	//global.player.x - camera_get_view_x(view_camera[0]), global.player.y) - camera_get_view_y(view_camera[0]) - 90;
	
	//scale_distance_ratio = distance_to_player / sprite_get_height(sprite_index);
	
	is_on = true;
}

#endregion

#region Move Towards Player

if(is_on){
	
	
	//if(bounce_counter < 1){
		move_towards_point( array_get(player_location_snapshot, 0), array_get(player_location_snapshot, 1), movement_speed);
	//}
	
}

#endregion


#region Collision with Solid

/*
if(place_meeting(x, y, all)){
	
	
	if(other != obj_enemy && other!= obj_melee_weapon_enemy){
		show_debug_message("projectile collision");
		var index = ds_list_find_index(owner.projectiles, self);
		ds_list_delete(owner.projectiles, index);
		instance_destroy();
	}
	
	
	/*
	//if the collision is with a tilemap, destroy the projectile
	if(layer_get_element_type(other) == layerelementtype_tilemap){
		show_debug_message("collision with tiles");
		var index = ds_list_find_index(owner.projectiles, self);
		ds_list_delete(owner.projectiles, index);
		instance_destroy();
	}
	else show_debug_message("collision with " + string(other));
	*/
	
	/*
	//destroy on impact if it cannot bounce or player was hit
	if(!can_bounce || place_meeting(x, y, obj_player)){
		var index = ds_list_find_index(owner.projectiles, self);
		ds_list_delete(owner.projectiles, index);
		instance_destroy();
	}
	//bounce
	else{
		//TODO: handle bouncing
		//var bounce_collision_pt = scr_get_tm_collision_point(x, y, "Tiles");
		if(bounce_counter < bounce_number){
			bounce_counter++;
			direction = -direction;
		}
	}
	
}
*/


if(place_meeting(x, y, obj_player)){
	show_debug_message("collision with player");
	var index = ds_list_find_index(owner.projectiles, self);
	ds_list_delete(owner.projectiles, index);
	instance_destroy();
}


if(place_meeting(x, y, obj_projectile_weapon_enemy)){
	show_debug_message("collision with projectile");
	var index = ds_list_find_index(owner.projectiles, self);
	ds_list_delete(owner.projectiles, index);
	instance_destroy();	
}

if(place_meeting(x, y, [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Floor")])){
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