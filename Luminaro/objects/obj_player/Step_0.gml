

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

if(place_meeting(x, y + global.grav, obj_solid)){
	jump_state = E_JUMP_STATE.GROUNDED;
	
}
if(!place_meeting(x, y, obj_solid) && jump_current == 0 && jump_state == E_JUMP_STATE.GROUNDED && y != (room_height - sprite_height)){
	jump_state = E_JUMP_STATE.FALLING;
	
}

#endregion

#region reset jumps


if(jump_state == E_JUMP_STATE.GROUNDED && jump_current > 0){
	jump_current = 0;
	
}

#endregion

#region keep player on screen

//TODO: scroll the screen and make larger rooms?

if(x < 0) x = 0;
if(x > (room_width - sprite_width)) x = room_width - sprite_width;
if(y < 0) y = 0;

//TODO: if player goes off the bottom of screen death?
if(y > (room_height - sprite_height)){
	y = room_height - sprite_height;
	jump_state = E_JUMP_STATE.GROUNDED;
}

#endregion

#region gravity

if(jump_state != E_JUMP_STATE.GROUNDED){
	//additional gravity when falling(as opposed to jumping)
	if(jump_state == E_JUMP_STATE.FALLING) y = y + (.5 * global.grav);
	y = y + global.grav;
}

#endregion

#region pickup item

if(place_meeting(x, y, obj_pickup_item)){
	var pickup = instance_place(x, y, obj_pickup_item);
	
	if(pickup.type == E_PICKUP_TYPES.HEALTH){
		hp += pickup.amount;
		show_debug_message("hp = " + string(hp));
	}
	else if(pickup.type == E_PICKUP_TYPES.XP){
		xp += pickup.amount;
		show_debug_message("xp = " + string(xp));
	}
	else if(pickup.type == E_PICKUP_TYPES.MESSAGE){
		show_message(pickup.message_string);
	}
	
	//TODO: play sound
	//TODO: play effect
	
	instance_destroy(pickup);
	
}

#endregion

#region Death

if(variable_instance_exists(id, "dynamic_hp")){
	if(dynamic_hp <= 0){
		show_debug_message("player " + string(id) + " death.");
		room_goto(rm_death_screen);
	}
}


#endregion



#region INPUT: left

if(keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
	if(!place_meeting(x - dynamic_movement_speed, y, obj_wall)){
		global.button_held_time = 0;
		global.button_held = E_BUTTON_HELD.NONE;
		facing = E_FACING.left;
		//if(!place_meeting(x - movement_speed, y, obj_solid)) 
		x = x - dynamic_movement_speed;
		//if(place_meeting(x, y, obj_wall)) x = xprevious;
	}
}

if(keyboard_check(ord("A")) || keyboard_check(vk_left)){
	global.button_held_time++;
	if(global.button_held_time > global.button_held_threshold){
		global.button_held = E_BUTTON_HELD.LEFT;
	}
}

if(global.button_held == E_BUTTON_HELD.LEFT){
	//if(!place_meeting(x - movement_speed, y, obj_solid)) 
	if(!place_meeting(x - dynamic_movement_speed, y, obj_wall)){
		x = x - dynamic_movement_speed/2;
		//if(place_meeting(x, y, obj_wall)) x = xprevious;
	}
}


#endregion

#region INPUT: right

if(keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
	if(!place_meeting(x + dynamic_movement_speed, y, obj_wall)){
		global.button_held_time = 0;
		global.button_held = E_BUTTON_HELD.NONE;
		facing = E_FACING.right;
		//if(!place_meeting(x + movement_speed, y, obj_solid)) 
		x = x + dynamic_movement_speed;
		//if(place_meeting(x, y, obj_wall)) x = xprevious;
	}
}


if(keyboard_check(ord("D")) || keyboard_check(vk_right)){
	global.button_held_time++;
	if(global.button_held_time > global.button_held_threshold){
		global.button_held = E_BUTTON_HELD.RIGHT;
	}
}

if(global.button_held == E_BUTTON_HELD.RIGHT){
	if(!place_meeting(x + dynamic_movement_speed, y, obj_wall)){
		x = x + dynamic_movement_speed/2;
		//if(place_meeting(x, y, obj_wall)) x = xprevious;
	}
}

#endregion

#region INPUT: stop

if(keyboard_check_released(ord("A")) || keyboard_check_released(vk_left) || keyboard_check_released(ord("D")) || keyboard_check_released(vk_right)){
	global.button_held_time = 0;
	global.button_held = E_BUTTON_HELD.NONE;
}

#endregion

#region INPUT: jump
	
if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space)){
		
	if(jump_state != E_JUMP_STATE.JUMPING){
			
		jump_state = E_JUMP_STATE.JUMPING;
		
		//jump from ground
		jump_current++;
		
		if(!place_meeting(x, y - dynamic_jump_height, obj_solid)) y = y - dynamic_jump_height;
		
			
		instance_create_layer(x, bbox_bottom, "Instances", obj_effect_jump);
			
			
			
	}
	else if(jump_state == E_JUMP_STATE.JUMPING){
		if(jump_current < dynamic_jump_number){
				
			//double jump
			jump_current++;
			
			if(!place_meeting(x, y - dynamic_jump_height, obj_solid)) y = y - dynamic_jump_height;
			
			
			instance_create_layer(x, bbox_bottom,  "Instances", obj_effect_jump);
				
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
	
	if(mouse_x > x) facing = E_FACING.right;
	else facing = E_FACING.left;
	
	beam.image_angle = point_direction(x, y, mouse_x, mouse_y);
	beam.sprite_rotation = beam.image_angle;
	
	
	lantern.is_on = false;
	beam.is_on = true;
	
	
}

if(mouse_check_button_released(mb_left)){
	
	beam.is_on = false;
	lantern.is_on = true;
	
	
}

#endregion

#region INPUT: wide beam

if(keyboard_check_pressed(vk_lshift)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.WIDE;
	}
}

if(keyboard_check_released(vk_lshift)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	}
}

#endregion

#region INPUT: narrow beam

if(keyboard_check_pressed(vk_lalt)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NARROW;
	}
}

if(keyboard_check_released(vk_lalt)){
	if(beam.is_on){
		beam.size = E_LIGHT_SIZE.NORMAL;
	}
}

#endregion


#region INPUT: create a mirror

if(mouse_check_button_pressed(mb_right)){
	
	var mirror = instance_create_layer(mouse_x, mouse_y, "Instances", obj_mirror);
	
	//if there are already the max number, remove the oldest
	if(array_length(mirrors) == max_mirrors){
		instance_destroy(array_get(mirrors, 0));
		array_shift(mirrors);
	}
	
	array_push(mirrors, mirror);
	
}

#endregion











