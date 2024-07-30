

if(global.game_state == E_GAME_STATE.PLAYING){
	
#region init	

if(init){
	
	#region display size for browser
	if(os_browser != browser_not_a_browser){
		var _dw = 99*browser_width/100;
		var _dh = 99*browser_height/100;
	
		display_set_gui_size(_dw, _dh);
		//window_set_size(_dw, _dh);
		camera_set_view_size(view_camera[0], _dw, _dh);
		surface_resize(application_surface, _dw, _dh);
		window_set_rectangle(0, 0, _dw, _dh);
	
		display_set_gui_size(_dw, _dh);
		global.dg_width = display_get_width();
		global.dg_height = display_get_height();
	
	}
	#endregion



}

#endregion
	

#region timer

//store time in seconds	
time_counter = time_counter + (delta_time / 1000000);
if(keyboard_check_pressed(ord("T"))){
	show_debug_message(string(time_counter));
}

#endregion



#region Sprite Index

//handle all sprite changes using states here

//store previous sprite so we can compare to see if the sprite changed
var prev_sprite_index = sprite_index;




if(facing == E_FACING.right){
	if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.GROUNDED){
		sprite_index = spr_player_idle;		
	}
	else if(standing_state == E_STANDING_STATE.WALKING && jump_state == E_JUMP_STATE.GROUNDED){
		sprite_index = spr_player_walking;		
	}
	else if(standing_state == E_STANDING_STATE.CROUCHING && jump_state == E_JUMP_STATE.GROUNDED ){
		sprite_index = spr_player_crouching;
	}
	else if(jump_state == E_JUMP_STATE.JUMPING){
		sprite_index = spr_player_jumping;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.FALLING){
		sprite_index = spr_player_falling;
	}
}
else if(facing == E_FACING.left){
		
	if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.GROUNDED){
		sprite_index = spr_player_idle_l;	
	}
	else if(standing_state == E_STANDING_STATE.WALKING && jump_state == E_JUMP_STATE.GROUNDED){
		sprite_index = spr_player_walking_l;
	}
	else if(standing_state == E_STANDING_STATE.CROUCHING && jump_state == E_JUMP_STATE.GROUNDED){
		sprite_index = spr_player_crouching_l;
	}
	else if(jump_state == E_JUMP_STATE.JUMPING){
		sprite_index = spr_player_jumping_l;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.FALLING){
		sprite_index = spr_player_falling_l;
	}
}


//if sprite changed, set index to 0
if(sprite_index != prev_sprite_index){
	image_index = 0;
}

#endregion



#region Process Movement

// capture decimals
var hsp_decimal = frac(hsp);
var vsp_decimal = frac(vsp);

hsp -= hsp_decimal;
vsp -= vsp_decimal;

#region -- Solid Collisions --
// Horizontal collision
if (hsp > 0) bbox_side = bbox_right; else bbox_side = bbox_left;
if (	tilemap_get_at_pixel(wall_tiles, bbox_side+hsp, bbox_top) != 0 
	||	tilemap_get_at_pixel(wall_tiles, bbox_side+hsp, bbox_bottom) != 0) {

    if (hsp > 0) x = x - (x mod 32) + 31 - (bbox_right - x);
    else x = x - (x mod 32) - (bbox_left - x);
    hsp = 0;
   
}

// Vertical collision
if (vsp > 0) bbox_side = bbox_bottom; else bbox_side = bbox_top;
if (	tilemap_get_at_pixel(floor_tiles, bbox_left, bbox_side+vsp) != 0
	||  tilemap_get_at_pixel(floor_tiles, bbox_right, bbox_side+vsp) != 0
	||  tilemap_get_at_pixel(ceiling_tiles, bbox_left, bbox_side+vsp) != 0 
	||  tilemap_get_at_pixel(ceiling_tiles, bbox_right, bbox_side+vsp) != 0
	) {

    if (vsp > 0) {
        y = y - (y mod 32) + 31 - (bbox_bottom - y);
    } else {
		
        y = y - (y mod 32) - (bbox_top - y);
    }  
   
    vsp = 0;
}

#region -- One Way Collisions --

// check if the player is falling, or walking onto the platform

if (	tilemap_get_at_pixel(floor_tiles, bbox_left, bbox_bottom+vsp) != 0 
	||	tilemap_get_at_pixel(floor_tiles, bbox_right, bbox_bottom+vsp) != 0
	||	tilemap_get_at_pixel(ceiling_tiles, bbox_left, bbox_bottom+vsp) != 0 
	||	tilemap_get_at_pixel(ceiling_tiles, bbox_right, bbox_bottom+vsp) != 0
	
	) {

    var tileY = (y div 32) * 32;
    if bbox_bottom >= tileY-32 && vsp >= 0 {  
        y = y + (y mod 32) - 31 + (bbox_bottom - y);
        vsp = 0;
    }
	else if(jump_state != E_JUMP_STATE.JUMPING ) jump_state = E_JUMP_STATE.FALLING;
}
#endregion

#region check grounded
if (	tilemap_get_at_pixel(floor_tiles, bbox_left, bbox_bottom+1) 
	||	tilemap_get_at_pixel(floor_tiles, bbox_right, bbox_bottom+1)) 
	&&	vsp == 0 {
   
    var tileY = (y div 32) * 32;
    if bbox_bottom+1 >= tileY-32 {  
       jump_state = E_JUMP_STATE.GROUNDED;
    }
} else {
    if(jump_state != E_JUMP_STATE.JUMPING ) jump_state = E_JUMP_STATE.FALLING;
}
#endregion

// apply speeds
x += hsp;
y += vsp;

hsp = 0;
vsp = 0;

#endregion


#region Ground player / Fall
/*

if(jump_state != E_JUMP_STATE.GROUNDED){
	//increase acceleration
	global.grav_acceleration = global.grav_acceleration * global.grav_delta_a;
	//calculate gravity
	var g = round(clamp(global.grav + global.grav_acceleration, global.grav, global.terminal_velocity));

	if(place_meeting(x, y + g, layer_tilemap_get_id("Tiles_Floor"))){ // || place_meeting(x, y + g, obj_floor)
		
		var coll_x = x + tilemap_get_cell_x_at_pixel(layer_tilemap_get_id("Tiles_Floor"), x , y);
		var coll_y = y + tilemap_get_cell_y_at_pixel(layer_tilemap_get_id("Tiles_Floor"), x , y);
		collision_x = coll_x;
		collision_y = coll_y;
		var dir = point_direction(x, y, coll_x, coll_y)
		
		if(dir > 181 || dir < 0.5){
			show_debug_message("dir = " + string(dir));
			jump_state = E_JUMP_STATE.GROUNDED;
			jump_float_counter = 0;
			jump_current = 0;
			jump_y_counter = 0;
			global.grav_acceleration = global.starting_grav_a;
		}
		else{
			show_debug_message("player step: hit floor from below");
		}
		
	}
}
else{
	
	//global.grav_acceleration = global.grav_acceleration * global.grav_delta_a;
	//calculate gravity
	//var g = round(clamp(global.grav + global.grav_acceleration, global.grav, global.terminal_velocity));
	
	if(!place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor"))
	&& jump_current == 0
	&& y != (room_height - sprite_height)){
		jump_state = E_JUMP_STATE.FALLING;
	
	} // && !place_meeting(x, y + g, obj_floor)

}
*/




#endregion

#region reset jumps


if(jump_state == E_JUMP_STATE.GROUNDED && jump_current > 0){
	jump_float_counter = 0;
	jump_current = 0;
	jump_y_counter = 0;
	global.grav_acceleration = global.starting_grav_a;
	
}

#endregion


#region gravity and jumping

if(jump_state == E_JUMP_STATE.JUMPING && jump_float_counter < dynamic_jump_float_time){
	jump_float_counter = jump_float_counter + (delta_time / 1000000);
}

//if not on the ground
if(jump_state != E_JUMP_STATE.GROUNDED){
	//and not jumping OR past the jump hover time
	if( jump_state != E_JUMP_STATE.JUMPING || (jump_float_counter >= dynamic_jump_float_time)){
		
		//increase acceleration
		global.grav_acceleration = global.grav_acceleration * global.grav_delta_a;
		//calculate gravity
		var g = round(clamp(global.grav + global.grav_acceleration, global.grav, global.terminal_velocity));
		
		
		vsp += g;
		
		/*
		//if applying gravity will not put the player in collision
		if(!place_meeting(x, y + g, layer_tilemap_get_id("Tiles_Floor"))){
			//apply gravity
			 y = y + g;
		}*/
	
	}
}

//if hit ceiling, fall 
if(jump_state == E_JUMP_STATE.JUMPING){
	
	//show_debug_message("jump_y_counter = " + string(jump_y_counter));
	
	if(jump_y_counter < dynamic_jump_height){
		jump_y_counter += jump_y_increment;
		vsp -= jump_y_increment;
		
		/*
		if(place_meeting(x, y + jump_y_increment, layer_tilemap_get_id("Tiles_Ceiling"))){ // || place_meeting(x, y + jump_y_increment, obj_ceiling)
		
			//increase acceleration
			global.grav_acceleration = global.grav_acceleration * global.grav_delta_a;
			//calculate gravity
			var g = round(clamp(global.grav + global.grav_acceleration, global.grav, global.terminal_velocity));
			
			//apply gravity
			 y = y + g;
			 
			jump_state = E_JUMP_STATE.FALLING;
		}
		else{
			jump_y_counter += jump_y_increment;
			y -= jump_y_increment;
		}
		*/
	}
}

#endregion

#region pickup item

if(display_message_on){
	display_message_timer = display_message_timer + (delta_time / 1000000);
	if(display_message_timer > display_message_time_duration){
		display_message_on = false;
	}
}

if(special_display_message_on){
	special_display_message_timer = special_display_message_timer + (delta_time / 1000000);
	if(special_display_message_timer > special_display_message_time_duration){
		special_display_message_on = false;
	}
}

if(place_meeting(x, y, obj_pickup_item)){
	var pickup = instance_place(x, y, obj_pickup_item);
	
	if(pickup.type == E_PICKUP_TYPES.HEALTH){
		dynamic_hp += pickup.amount;
		show_debug_message("hp = " + string(dynamic_hp));
	}
	else if(pickup.type == E_PICKUP_TYPES.XP){
		xp += pickup.amount;
		show_debug_message("xp = " + string(xp));
	}
	else if(pickup.type == E_PICKUP_TYPES.MESSAGE){
		show_message(pickup.message_string);
	}
	else if (pickup.type == E_PICKUP_TYPES.INVENTORY){
		 
		 //add the item type E_INVENTORY_ITEM_TYPES to the inventory
		 if(array_length(inventory) < inventory_max){
			array_push(inventory, pickup.inventory_item_type);
			scr_set_player_stats(global.player, true);
		}
		 else{
			//TODO: tell play inventory full
			show_debug_message("inventory is full");
		 }
		 
		 
	}
	else if (pickup.type == E_PICKUP_TYPES.UPGRADE){

		global.game_state = E_GAME_STATE.IN_GAME_MENU;
		global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
		global.player_menu.state = E_PLAYER_MENU_STATE.LEVEL_UP;
		global.player_menu.is_special_upgrade = true;
		global.player_menu.level_option = pickup.upgrade_type;
		global.player_menu.upgrade_quality = pickup.upgrade_quality;

	
	}
	
	//TODO: play sound
	//TODO: play effect
	
	instance_destroy(pickup);
	
}

#endregion

#region Battery

if(!battery_has_charge || attack_state == E_ATTACK_STATE.idle){
	//if the batter didn't fully die, decrement timer twice as fast as if it died
	if(battery_has_charge){
		//on_timer = clamp(on_timer - 2, 0, dynamic_battery);
		on_timer = clamp(on_timer - ((delta_time / 1000000) * 1.3), 0, dynamic_battery);
		//show_debug_message("on_timer = " + string(on_timer));
	}
	else {
		battery_charge_timer = battery_charge_timer + (delta_time / 1000000);
		//show_debug_message("battery charge timer = " + string(battery_charge_timer));
	}
	
	if( battery_charge_timer > dynamic_battery_charge_delay ){
		on_timer = 0;
		battery_charge_timer = 0;
		battery_has_charge = true;
	}
}


if(attack_state == E_ATTACK_STATE.beam){
	if(beam.is_on){
		//on_timer++;
		on_timer = on_timer + (delta_time / 1000000);
	}

	if(on_timer > dynamic_battery){
		show_debug_message("beam battery died");
		attack_state = E_ATTACK_STATE.idle;
		beam.size = E_LIGHT_SIZE.NORMAL;
		beam.is_on = false;
		battery_has_charge = false;
	}

}

if(attack_state == E_ATTACK_STATE.prism){
	if(ds_list_size(prism_beams) > 0){
		on_timer = on_timer + (delta_time / 1000000);
		
		if(on_timer > dynamic_battery){
			
			with(obj_light){
				if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
					instance_destroy();
				}
			}
			
			//and clear the list
			ds_list_clear(prism_beams);
			battery_has_charge = false;
	
			attack_state = E_ATTACK_STATE.idle;
			lantern.is_on = true;
	
		}
	}
}

#endregion

#region Catalyst Charging

//if we are not at max catalyst charges
if(current_catalyst_charges < dynamic_catalyst_number){
	catalyst_charge_timer = catalyst_charge_timer + (delta_time / 1000000);
	
	//if the timer is ready
	if(catalyst_charge_timer > dynamic_catalyst_charge_delay){
		catalyst_charge_timer = 0;
		
		//add a catalyst charge
		current_catalyst_charges++; 
		show_debug_message("obj player: catalyst timer ready. current catalyst charges = " + string(current_catalyst_charges));
	}
}


#endregion

#region Level Up

if(xp >= 100){
	
	xp = xp - 100;
	global.game_state = E_GAME_STATE.IN_GAME_MENU;
	global.player_menu = instance_create_layer(0, 0, "UI", obj_player_menu);
	global.player_menu.state = E_PLAYER_MENU_STATE.LEVEL_UP;
	
}

#endregion

#region Contact Damage

if(place_meeting(x, y, obj_enemy)){
	//show_debug_message("enemy collision with player");

	dynamic_hp = dynamic_hp - (other.level)/2;

}

if(place_meeting(x, y, obj_boss)){
	//show_debug_message("boss collision with player");

	dynamic_hp = dynamic_hp - 3*other.level;

}


#endregion

#region Death

if(variable_instance_exists(id, "dynamic_hp")){
	if(dynamic_hp <= 0){
		show_debug_message("player " + string(id) + " death.");
		global.game_state = E_GAME_STATE.DEATH_SCREEN;
		instance_deactivate_all(true);
		room_goto(rm_death_screen);
	}
}


#endregion

#region Level Transition

if(boss_defeated){	


	#region check item requirement
	
	if(global.current_level == E_LEVELS.LEVEL_1){
		if(array_contains(inventory, E_INVENTORY_ITEM_TYPES.TYPE_0)){
			has_required_item = true;
		}
	}
	else if(global.current_level == E_LEVELS.LEVEL_2){
		if(array_contains(inventory, E_INVENTORY_ITEM_TYPES.TYPE_2)){
			has_required_item = true;
		}
	}
	
	#endregion
	
	
	#region Transition

	if(has_required_item && !transition_spawned){
	
		transition_spawned = true;
	
		if(collision_line(x, y, x + 100, y - sprite_get_height(spr_player_idle), [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Floor")], false, false) == noone ){
			var level_transition = instance_create_layer(x + 100, y - sprite_get_height(spr_player_idle), "Items", obj_level_transition);
			show_debug_message("scr player spawn level transition: spawn A");
		}
		else if(collision_line(x, y, x - 100, y - sprite_get_height(spr_player_idle), [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Floor")], false, false) == noone ){
			var level_transition = instance_create_layer(x - 100, y - sprite_get_height(spr_player_idle), "Items", obj_level_transition);
			show_debug_message("scr player spawn level transition: spawn b");
		}
		else if(collision_line(x, y, x, y - 100 - sprite_get_height(spr_player_idle), [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Floor")], false, false) == noone ){
			var level_transition = instance_create_layer(x, y - 100 - sprite_get_height(spr_player_idle), "Items", obj_level_transition);
			show_debug_message("scr player spawn level transition: spawn c");
		}
		else if (collision_line(x, y, x, y + 100 - sprite_get_height(spr_player_idle), [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling"), layer_tilemap_get_id("Tiles_Floor")], false, false) == noone ){
			var level_transition = instance_create_layer(x, y + 100 - sprite_get_height(spr_player_idle), "Items", obj_level_transition);
			show_debug_message("scr player spawn level transition: spawn d");
		}
		else{
			var level_transition = instance_create_layer(x, y - sprite_get_height(spr_player_idle)/2, "Items", obj_level_transition);
			show_debug_message("scr player spawn level transition: spawn e");
		}
	
	}
	
	#endregion
	
}



#endregion



#region INPUT: left

if(keyboard_check(ord("A")) || keyboard_check(vk_left)){
	
	facing = E_FACING.left;
		standing_state = E_STANDING_STATE.WALKING;
	hsp = - dynamic_movement_speed;
	
	show_debug_message("hsp = "+ string(hsp));
	/*
	if(!place_meeting(x - round(dynamic_movement_speed), y, layer_tilemap_get_id("Tiles_Walls"))){ // && !place_meeting(x - dynamic_movement_speed, y, obj_wall)
		
		facing = E_FACING.left;
		standing_state = E_STANDING_STATE.WALKING;
		x = x - round(dynamic_movement_speed);
	}
	else{
		
	*/	
		
		//show_debug_message("player step: move left: collision x = " + string(collision_x) + ". y = " + string(collision_y));
		
		//standing_state = E_STANDING_STATE.STANDING;
		
		//x = xprevious;
		
		/*
		while (!place_meeting(x - 1, y, layer_tilemap_get_id("Tiles_Walls"))){
			facing = E_FACING.left;
			standing_state = E_STANDING_STATE.WALKING;
            x--;
        }*/
		
		//standing_state = E_STANDING_STATE.STANDING;
		
	//}
	
	
}


#endregion

#region INPUT: right


if(keyboard_check(ord("D")) || keyboard_check(vk_right)){
	
	facing = E_FACING.right;
	standing_state = E_STANDING_STATE.WALKING;
	hsp = dynamic_movement_speed;
	
	
	
	/*
	if(jump_state == E_JUMP_STATE.JUMPING){
		if(!place_meeting(x + round(dynamic_movement_speed), y + round(jump_y_increment), [layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling")])){
			
			facing = E_FACING.right;
			standing_state = E_STANDING_STATE.WALKING;
			x = x + round(dynamic_movement_speed);
		}
		else{
			
			
			//standing_state = E_STANDING_STATE.STANDING;
			/*
			while (!place_meeting(x + 1, y, [layer_tilemap_get_id("Tiles_Floor"), layer_tilemap_get_id("Tiles_Walls"), layer_tilemap_get_id("Tiles_Ceiling")])){
				facing = E_FACING.right;
				standing_state = E_STANDING_STATE.WALKING;
	            x++;
			}
			*/
		
		//standing_state = E_STANDING_STATE.STANDING;
		
		/*
		}
	}
	else if(!place_meeting(x + round(dynamic_movement_speed), y, layer_tilemap_get_id("Tiles_Walls"))){ // && !place_meeting(x - dynamic_movement_speed, y, obj_wall)
		
		facing = E_FACING.right;
		standing_state = E_STANDING_STATE.WALKING;
		x = x + round(dynamic_movement_speed);
	}
	else{
		*/
		
		//standing_state = E_STANDING_STATE.STANDING;
		
		//x = xprevious;
		
	/*
		while (!place_meeting(x + 1, y, layer_tilemap_get_id("Tiles_Walls")))
        {
			facing = E_FACING.right;
			standing_state = E_STANDING_STATE.WALKING;
            x++;
        }
		*/
		
		//standing_state = E_STANDING_STATE.STANDING;
	
	//}
	
}



#endregion


#region Hold stop

if(keyboard_check_released(ord("A")) || keyboard_check_released(vk_left) || keyboard_check_released(ord("D")) || keyboard_check_released(vk_right) || keyboard_check_released(ord("C")) || keyboard_check_released(vk_lcontrol) || keyboard_check_released(ord("S")) || keyboard_check_released(vk_down)){			
	standing_state = E_STANDING_STATE.STANDING;
}

#endregion


#region INPUT: jump
	
if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"))){
		
	if(jump_state != E_JUMP_STATE.JUMPING){
		
		if(standing_state != E_STANDING_STATE.STANDING) standing_state = E_STANDING_STATE.STANDING;
		
		
		global.grav_acceleration = global.starting_grav_a;
		
		jump_state = E_JUMP_STATE.JUMPING;
		
		jump_current++;
		
		jump_y_counter += jump_y_increment;
		vsp -= jump_y_increment;
		
		/*
		if(!place_meeting(x, y - jump_y_increment, layer_tilemap_get_id("Tiles_Ceiling"))){ // && !place_meeting(x, y + 1, obj_ceiling)
			jump_y_counter += jump_y_increment;
			y -= jump_y_increment;
		}
		else{
		
			while(!place_meeting(x, y - sign(jump_y_increment),layer_tilemap_get_id("Tiles_Ceiling") )){
				y -= sign(jump_y_increment);
			}
			
			
			jump_state = E_JUMP_STATE.FALLING;
		
		}
		*/
	
	
		//instance_create_layer(x, bbox_bottom, "Effects", obj_effect_jump);
			
			
			
	}
	else if(jump_state == E_JUMP_STATE.JUMPING){
		if(jump_current < dynamic_jump_number){
			
			jump_y_counter = 0;
			
			global.grav_acceleration = global.starting_grav_a;
			
			//double jump
			jump_current++;
			
			vsp -= jump_y_increment;
			
			/*
			if(!place_meeting(x, y - jump_y_increment, layer_tilemap_get_id("Tiles_Ceiling"))){ // && !place_meeting(x, y + 1, obj_ceiling)
				jump_y_counter += jump_y_increment;
				y -= jump_y_increment;
			}
			else{
				
				*/
		/*
				while(!place_meeting(x, y - sign(jump_y_increment),layer_tilemap_get_id("Tiles_Ceiling") )){
					y -= sign(jump_y_increment);
				}
				*/
				
			//	jump_state = E_JUMP_STATE.FALLING;
		
			//}
			
			
			/*
			if(!place_meeting(x, y + 1, layer_tilemap_get_id("Tiles_Ceiling"))){ // && !place_meeting(x, y + 1, obj_ceiling)
				jump_y_counter += jump_y_increment;
				y -= jump_y_increment;
			}*/
			
			//if(!place_meeting(x, y - dynamic_jump_height, layer_tilemap_get_id("Tiles_Ceiling"))) y = y - dynamic_jump_height;
			
			
			//instance_create_layer(x, bbox_bottom,  "Effects", obj_effect_jump);
				
		}
	}
}



#endregion

#region INPUT: crouch and fall faster

if(keyboard_check(ord("C")) || keyboard_check(vk_lcontrol) || keyboard_check(ord("S")) || keyboard_check(vk_down)){
	
	
	if(!jump_state == E_JUMP_STATE.GROUNDED){
		global.grav_acceleration = global.terminal_velocity;
	}
	else{
		standing_state = E_STANDING_STATE.CROUCHING;
	}
}



#endregion

#region INPUT: light beam

if(mouse_check_button(mb_left)){
	
	if(battery_has_charge && !beam.is_on) beam.is_on = true;
		
	if(beam.is_on){
		if(lantern.is_on) lantern.is_on = false;
		if(attack_state != E_ATTACK_STATE.beam) attack_state = E_ATTACK_STATE.beam;
		
		if(mouse_x > x) facing = E_FACING.right;
		else facing = E_FACING.left;
	
		beam.image_angle = point_direction(x + beam.x_offset, y - beam_holding_height, device_mouse_x(0), device_mouse_y(0));
		
		
	}
	else{
		//show_debug_message("TODO: play effect and sound to tell player battery is dead. and text?  ");
	}
	
}

if(mouse_check_button_released(mb_left)){
	
	attack_state = E_ATTACK_STATE.idle;
	beam.is_on = false;
	lantern.is_on = true;
	
	
}

#endregion

#region INPUT: wide beam

if(keyboard_check_pressed(vk_insert) || keyboard_check_pressed(ord("E"))){
	
	if(beam.size != E_LIGHT_SIZE.WIDE) beam.size = E_LIGHT_SIZE.WIDE;
	else beam.size = E_LIGHT_SIZE.NORMAL;

	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				if(size != E_LIGHT_SIZE.WIDE) size = E_LIGHT_SIZE.WIDE;
				else size = E_LIGHT_SIZE.NORMAL;
			}
		}
	}
}

/*
if(keyboard_check_released(vk_insert) || keyboard_check_released(ord("E"))){
	//if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	//}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.NORMAL;
			}
		}
	}
}
*/

#endregion

#region INPUT: narrow beam

if(keyboard_check(vk_end) || keyboard_check(ord("Q"))){
	
	if(beam.size != E_LIGHT_SIZE.NARROW) beam.size = E_LIGHT_SIZE.NARROW;
	else beam.size = E_LIGHT_SIZE.NORMAL;
	
	
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				if(size != E_LIGHT_SIZE.NARROW) size = E_LIGHT_SIZE.NARROW;
				else size = E_LIGHT_SIZE.NORMAL;
			}
		}
	}
}

/*
if(keyboard_check_released(vk_end) || keyboard_check_released(ord("Q"))){
	//if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	//}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.NARROW;
			}
		}
	}
}
*/

#endregion

#region INPUT: create a Catalyst

if(mouse_check_button_pressed(mb_right)){

	//if we have a catalyst charge
	if(current_catalyst_charges > 0){
		current_catalyst_charges--;
		
		//if we do not have the max number of catalysts currently out make one where the mouse is
		if(current_spawned_catalysts < dynamic_catalyst_number){
			current_spawned_catalysts++; //decremented in obj_explosive_catalyst when clean up
			
			var catalyst = instance_create_layer(device_mouse_x(0), device_mouse_y(0), "Weapons", obj_explosive_catalyst);
			catalyst.max_size *= dynamic_catalyst_size_mod;
			
		}
	
	}
	
	
	
	/*
	var mirror = instance_create_layer(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), "Weapons", obj_mirror);
	mirror.owner = self;
	
	//if there are already the max number, remove the oldest
	if(array_length(mirrors) == max_mirrors){
		instance_destroy(array_get(mirrors, 0));
		array_shift(mirrors);
	}
	
	array_push(mirrors, mirror);
	*/
	
}

#endregion

#region INPUT: prism beam


if(mouse_check_button(mb_middle)){
	
	if(battery_has_charge){
		attack_state = E_ATTACK_STATE.prism;
		
		//spawn the beams if they are not out
		if(ds_list_size(prism_beams) <= 0){
			for(i = 0; i < dynamic_prism_beam_number; i++){
			
				var prism_beam = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Weapons", obj_light_beam);
				prism_beam.light_type = E_LIGHT_TYPES.PLAYER_PRISM_BEAM;
				prism_beam.holder = self;
				prism_beam.is_on = true;
			
				lantern.is_on = false;
			
				ds_list_add(prism_beams, prism_beam);
			}
		}
	
	
		//if there are beams, set the angles of the beams
		if(ds_list_size(prism_beams) > 0){
		
			for(j = 0; j < dynamic_prism_beam_number; j++){
			
				show_debug_message("j = " + string(j));
			
				var prism_beam = prism_beams[| j];
			
				var beam_gap_angle = prism_max_angle / dynamic_prism_beam_number;
		
				var start_point =  point_direction(x + beam.x_offset, y - beam_holding_height, device_mouse_x(0), device_mouse_y(0)) - prism_max_angle/2;

				prism_beam.image_angle = start_point + (j * beam_gap_angle);
			
			}
		}
	}
}


if(mouse_check_button_released(mb_middle)){
	
	
	with(obj_light){
		if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
			instance_destroy();
		}
	}
	
	
	/*
	//delete each beam
	if(ds_list_size(prism_beams) > 0){
		for(j = 0; j <= dynamic_prism_beam_number; j++){
			var prism_beam = prism_beams[| j];
			instance_destroy(prism_beam);
		}
	}
	*/
	
	attack_state = E_ATTACK_STATE.idle;
	lantern.is_on = true;
	
	//and clear the list
	ds_list_clear(prism_beams);
	
}


#endregion






}












