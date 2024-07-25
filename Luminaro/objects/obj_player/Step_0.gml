
if(global.game_state == E_GAME_STATE.PLAYING){

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
	if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_player;
	}
	else if(standing_state == E_STANDING_STATE.CROUCHING && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_crouching_player;
	}
	else if(standing_state == E_STANDING_STATE.PRONE && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_prone_player;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.JUMPING && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_jumping_player;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.FALLING && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_falling_player;
	}
}
else if(facing == E_FACING.left){
	if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_player_l;
	}
	else if(standing_state == E_STANDING_STATE.CROUCHING && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_crouching_player_l;
	}
	else if(standing_state == E_STANDING_STATE.PRONE && jump_state == E_JUMP_STATE.GROUNDED && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_prone_player_l;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.JUMPING && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_jumping_player_l;
	}
	else if(standing_state == E_STANDING_STATE.STANDING && jump_state == E_JUMP_STATE.FALLING && attack_state == E_ATTACK_STATE.idle && react_state == E_REACT_STATE.idle){
		sprite_index = spr_falling_player_l;
	}
}


//if sprite changed, set index to 0
if(sprite_index != prev_sprite_index) image_index = 0;


#endregion

#region Ground player / Fall

if(place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor"))){
	jump_state = E_JUMP_STATE.GROUNDED;
}
if(!place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor")) 
&& jump_current == 0 && jump_state == E_JUMP_STATE.GROUNDED 
&& y != (room_height - sprite_height)){
	jump_state = E_JUMP_STATE.FALLING;
	
}

#endregion

#region reset jumps


if(jump_state == E_JUMP_STATE.GROUNDED && jump_current > 0){
	jump_float_counter = 0;
	jump_current = 0;
	
}

#endregion

#region keep player on screen


/*
TODO: remove this was disabled after room was made much larger for scrolling. could instead make dead happen if player is off screen?

if(x < 0) x = 0;
if(x > (room_width - sprite_width)) x = room_width - sprite_width;
if(y < 0) y = 0;

//TODO: if player goes off the bottom of screen death?
if(y > (room_height - sprite_height)){
	y = room_height - sprite_height;
	jump_state = E_JUMP_STATE.GROUNDED;
}
*/

#endregion

#region gravity and jumping

if(jump_state == E_JUMP_STATE.JUMPING && jump_float_counter < dynamic_jump_float_time){
	jump_float_counter++;
}

//if not on the ground
if(jump_state != E_JUMP_STATE.GROUNDED){
	//and not jumping OR past the jump hover time
	if( jump_state != E_JUMP_STATE.JUMPING || (jump_float_counter >= dynamic_jump_float_time)){
		
		//if applying gravity will not put the player in collision
		if(!place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor"))){
			
			//apply gravity
			 y = y + global.grav;
		
			//plus more gravity when "falling"
			//if(jump_state == E_JUMP_STATE.FALLING) y = y + (.5 * global.grav);
		}
	
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
			show_debug_message("inventory pickup. inventory size = " + string(array_length(inventory)) + ". last added = " + string(pickup.inventory_item_type));
		 }
		 else{
			//TODO: tell play inventory full
			show_debug_message("inventory is full");
		 }
		 
		 
	}
	
	//TODO: play sound
	//TODO: play effect
	
	instance_destroy(pickup);
	
}

#endregion

#region Battery

if(!battery_charged || attack_state == E_ATTACK_STATE.idle){
	//if the batter didn't fully die, decrement timer twice as fast as if it died
	if(on_timer > 0) on_timer = clamp(on_timer - 2, 0, dynamic_battery);
	
	battery_charge_timer++;
	if( battery_charge_timer > dynamic_battery_charge_delay ){
		on_timer = 0;
		battery_charge_timer = 0;
		battery_charged = true;
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
		beam.is_on = false;
		battery_charged = false;
	}

}

if(attack_state == E_ATTACK_STATE.prism){
	if(ds_list_size(prism_beams) > 0){
		other.on_timer++;
		
		if(on_timer > dynamic_battery){
			
			with(obj_light){
				if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
					instance_destroy();
				}
			}
			
			//and clear the list
			ds_list_clear(prism_beams);
			battery_charged = false;
	
			attack_state = E_ATTACK_STATE.idle;
			lantern.is_on = true;
	
		}
	}
}

#endregion

#region Catalyst Charging

//if we are not at max catalyst charges
if(current_catalyst_charges < dynamic_catalyst_number){
	catalyst_charge_timer++; 
	
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



#region INPUT: left

if(keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
	
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
	facing = E_FACING.left;
	if(!place_meeting(x - dynamic_movement_speed, y, layer_tilemap_get_id("Tiles_Walls"))){
		x = x - dynamic_movement_speed;
	}
}

if(keyboard_check(ord("A")) || keyboard_check(vk_left)){
	global.button_held_time++;
	if(global.button_held_time > global.button_held_threshold){
		global.button_held = E_BUTTON_HELD.LEFT;
	}
}

if(global.button_held == E_BUTTON_HELD.LEFT){
	if(!place_meeting(x - dynamic_movement_speed, y, layer_tilemap_get_id("Tiles_Walls"))){
		x = x - dynamic_movement_speed/2;
	}
}


#endregion

#region INPUT: right

if(keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
	facing = E_FACING.right;
	if(!place_meeting(x + dynamic_movement_speed, y, layer_tilemap_get_id("Tiles_Walls"))){
		x = x + dynamic_movement_speed;
	}
}


if(keyboard_check(ord("D")) || keyboard_check(vk_right)){
	global.button_held_time++;
	if(global.button_held_time > global.button_held_threshold){
		global.button_held = E_BUTTON_HELD.RIGHT;
	}
}

if(global.button_held == E_BUTTON_HELD.RIGHT){
	if(!place_meeting(x + dynamic_movement_speed, y, layer_tilemap_get_id("Tiles_Walls"))){
		x = x + dynamic_movement_speed/2;
	}
}

#endregion

#region Hold stop

if(keyboard_check_released(ord("A")) || keyboard_check_released(vk_left) || keyboard_check_released(ord("D")) || keyboard_check_released(vk_right)){
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
}

#endregion

#region INPUT: jump
	
if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space)){
		
	if(jump_state != E_JUMP_STATE.JUMPING){
			
		jump_state = E_JUMP_STATE.JUMPING;
		
		jump_current++;
		
		if(!place_meeting(x, y - dynamic_jump_height, layer_tilemap_get_id("Tiles_Ceiling"))) y = y - dynamic_jump_height;
		
			
		instance_create_layer(x, bbox_bottom, "Effects", obj_effect_jump);
			
			
			
	}
	else if(jump_state == E_JUMP_STATE.JUMPING){
		if(jump_current < dynamic_jump_number){
				
			//double jump
			jump_current++;
			
			if(!place_meeting(x, y - dynamic_jump_height, layer_tilemap_get_id("Tiles_Ceiling"))) y = y - dynamic_jump_height;
			
			
			instance_create_layer(x, bbox_bottom,  "Effects", obj_effect_jump);
				
		}
	}
}



#endregion

#region INPUT: crouch and prone

if(keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_lcontrol)){
	
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
	
	if(standing_state != E_STANDING_STATE.CROUCHING && standing_state != E_STANDING_STATE.PRONE){
		
		standing_state = E_STANDING_STATE.CROUCHING;
		
		dynamic_movement_speed = dynamic_movement_speed / 2;
	
	}
	else{
		
		standing_state = E_STANDING_STATE.STANDING;
		
		//TODO: y + half of the sprite size I think. sprite is too low when we change back. 
		
		dynamic_movement_speed = static_movement_speed;
		
	}	
}

if(keyboard_check(ord("C")) || keyboard_check(vk_lcontrol)){
	global.button_held_time++;
	if(global.button_held_time > global.button_held_threshold){
		global.button_held = E_BUTTON_HELD.CROUCH;
	}
}

if(global.button_held == E_BUTTON_HELD.CROUCH){
	standing_state = E_STANDING_STATE.PRONE;
		
	dynamic_movement_speed = dynamic_movement_speed / 2.5;
	
}



#endregion

#region INPUT: light beam

if(mouse_check_button(mb_left)){
	
	if(battery_charged && !beam.is_on) beam.is_on = true;
		
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

if(keyboard_check_pressed(vk_lshift)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.WIDE;
	}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.WIDE;
			}
		}
	}
}

if(keyboard_check_released(vk_lshift)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.NORMAL;
			}
		}
	}
}

#endregion

#region INPUT: narrow beam

if(keyboard_check_pressed(vk_lalt)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NARROW;
	}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.NARROW;
			}
		}
	}
}

if(keyboard_check_released(vk_lalt)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	}
	if(ds_list_size(prism_beams) > 0){
		with(obj_light){
			if(light_type == E_LIGHT_TYPES.PLAYER_PRISM_BEAM){
				size = E_LIGHT_SIZE.NARROW;
			}
		}
	}
}

#endregion

#region INPUT: create a .... catalyst    (previously mirror)

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
	
	if(battery_charged){
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












