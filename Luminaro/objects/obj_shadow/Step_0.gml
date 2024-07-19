

if((place_meeting(x, y, obj_light))){
	var light = instance_place(x, y, obj_light);
	if(light.is_on){
		show_debug_message("light hit shadow. type = " + string(light.light_type));
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


if(!supercharged && supercharge_timer > supercharge_rate){
	supercharge_timer = 0;
	
	supercharged = true;
	shadow_state = E_SHADOW_STATE.SUPERCHARGED;
	
	show_debug_message("supercharge on");
	//TODO: spawn supercharge effect on shadow
	
}

if(shadow_state == E_SHADOW_STATE.CHARGING){
	charge_timer++;
	if(charge_timer > charge_rate){
		charge_timer = 0;
		spawn_timer = spawn_rate;
		
		shadow_state = E_SHADOW_STATE.SPAWNING;
	}
}
else if(shadow_state == E_SHADOW_STATE.SPAWNING || shadow_state == E_SHADOW_STATE.SUPERCHARGED){
	if(spawn_timer > spawn_rate){
		spawn_timer = 0;
		
		randomize();
		var enemy_type = irandom_range(E_ENEMY_TYPES.BASIC, (E_ENEMY_TYPES.last - 1));
		scr_spawn_enemy(enemy_type, [x, y], supercharged);
	}
	
	spawn_timer++;
	if(!supercharged) supercharge_timer++;
}
