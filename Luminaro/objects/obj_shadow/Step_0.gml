


#region Handle Activation

if((place_meeting(x, y, obj_light))){
	var light = instance_place(x, y, obj_light);
	if(light.is_on){
		//show_debug_message("light hit shadow. type = " + string(light.light_type));
		shadow_state = E_SHADOW_STATE.DEACTIVATED;
		supercharged = false;
		supercharge_timer = 0;
		charge_timer = 0;
		spawn_timer = 0;
	}
	else if (shadow_state == E_SHADOW_STATE.DEACTIVATED){
		shadow_state = E_SHADOW_STATE.CHARGING;
	}
}
else if (shadow_state == E_SHADOW_STATE.DEACTIVATED){
	shadow_state = E_SHADOW_STATE.CHARGING;
}

#endregion


#region Handle Supercharge

if(!supercharged && supercharge_timer > supercharge_rate){
	supercharge_timer = 0;
	
	supercharged = true;
	shadow_state = E_SHADOW_STATE.SUPERCHARGED;
	
	show_debug_message("supercharge on");
	//TODO: spawn supercharge effect on shadow
	
}

#endregion


#region Handle Charging

if(shadow_state == E_SHADOW_STATE.CHARGING){
	
	charge_timer = charge_timer + (delta_time / 1000000);
	
	if(charge_timer > charge_rate){
		charge_timer = 0;
		
		spawn_timer = spawn_rate;
		
		shadow_state = E_SHADOW_STATE.SPAWNING;
	}
}
else if(shadow_state == E_SHADOW_STATE.SPAWNING || shadow_state == E_SHADOW_STATE.SUPERCHARGED){
	if(spawn_timer > spawn_rate && (distance_to_object(global.player) < spawn_distance_to_player)){
		spawn_timer = 0;
		
		randomize();
		
		var enemy_type = irandom_range(E_ENEMY_TYPES.BASIC, (E_ENEMY_TYPES.last - 1));
		scr_spawn_enemy(enemy_type, [x, y], supercharged);
	}
	
	spawn_timer = spawn_timer + (delta_time / 1000000);
	
	if(!supercharged) supercharge_timer++;
}

#endregion



#region Death

if(hp <= 0){
		
	randomize();
	var irand_health = irandom_range(0, 100);
	var irand_xp_offset = irandom_range(-100, 100);
	var irand_hp_offset = irandom_range(-100, 100) - irand_xp_offset;
		
	var xp_pickup = instance_create_layer(x + irand_xp_offset, y, "Items", obj_xp_pickup);
	xp_pickup.amount *= (level * 5);
		
		
	if(irand_health > 90) {
		var health_pickup = instance_create_layer(x + irand_hp_offset, y, "Items", obj_health_pickup);
		health_pickup.amount *= (level * 5);
	}
	
	//add self.shadow_type to the player's list of defeated enemies
	array_push(global.player.shadows_defeated, shadow_type);
		
	instance_destroy();
}


#endregion


