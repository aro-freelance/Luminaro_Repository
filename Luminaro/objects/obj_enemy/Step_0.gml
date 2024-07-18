
#region init

if(!parameter_init){
	
	if(supercharged){
		
		parameter_init = true;

		dynamic_movement_speed = 1.1 * static_movement_speed;

		dynamic_melee_attack_range = 1.1 * melee_attack_range;

		dynamic_can_float = can_float;

		dynamic_can_shoot = can_shoot;

		dynamic_ranged_attack_range = 1.3 * ranged_attack_range;

		dynamic_attack_rate = 1.5 * attack_rate;

		dynamic_hp = 3 * hp;
		
		show_debug_message("supercharged spawn");
		sprite_color = c_blue;
		//TODO: add an effect on the enemy that shows it is supercharged
	}
	else{
		
		parameter_init = true;

		dynamic_movement_speed = static_movement_speed;

		dynamic_melee_attack_range = melee_attack_range;

		dynamic_can_float = can_float;

		dynamic_can_shoot = can_shoot;

		dynamic_ranged_attack_range = ranged_attack_range;
		
		dynamic_attack_rate = attack_rate;

		dynamic_hp = hp;
		
	}
	
	//set distance goal
	if(dynamic_can_shoot) distance_goal = dynamic_ranged_attack_range;
	else distance_goal = dynamic_melee_attack_range;


}

#endregion

#region Sprite Index

//handle all sprite changes using states here

//store previous sprite so we can compare to see if the sprite changed
var prev_sprite_index = sprite_index;

if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.CROUCHING && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_crouching_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.PRONE && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_prone_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.JUMPING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_jumping_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.FALLING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_falling_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.FLOATING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_floating_enemy;
}


//if sprite changed, set index to 0
if(sprite_index != prev_sprite_index) image_index = 0;


#endregion


#region Ground enemy / Fall

if(place_meeting(x, y, obj_solid)){
	if(jump_state != E_ENEMY_JUMP_STATE.FLOATING) jump_state = E_ENEMY_JUMP_STATE.GROUNDED;
}
if(!place_meeting(x, y, obj_solid) && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && y != (room_height - sprite_height)){
	if(can_float){
		jump_state = E_ENEMY_JUMP_STATE.FLOATING;
	}
	else jump_state = E_JUMP_STATE.FALLING;	
}

#endregion


#region keep enemy on screen

//TODO: scroll the screen and make larger rooms?

if(x < 0) x = 0;
if(x > (room_width - sprite_width)) x = room_width - sprite_width;
if(y < 0) y = 0;

//TODO: if player goes off the bottom of screen death?
if(y > (room_height - sprite_height)){
	y = room_height - sprite_height;
	if(jump_state != E_ENEMY_JUMP_STATE.FLOATING) jump_state = E_JUMP_STATE.GROUNDED;
}

#endregion


#region gravity

if(jump_state != E_JUMP_STATE.GROUNDED){
	if(!can_float) y = y + global.grav;
}

#endregion


#region Movement

//check if the enemy can move
if(jump_state != E_ENEMY_JUMP_STATE.FALLING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	can_move = true;
}
else can_move = false;

if(can_move){
	if(!is_at_distance_goal){
		if(tactic_state == E_ENEMY_TACTIC_STATE.CHASE){
		
			goal_point = [global.player.x, global.player.y];
		
			//if not touching player, move closer
			if(!place_meeting(x, y, obj_player)) move_towards_point(global.player.x, global.player.y, dynamic_movement_speed);
		
		}
		else if(tactic_state == E_ENEMY_TACTIC_STATE.KEEP_DISTANCE || tactic_state == E_ENEMY_TACTIC_STATE.MOVE_AWAY_TO_SHOOT){
			//if too far, move closer
			if(distance_to_object(obj_player) > distance_goal){
				goal_point = [global.player.x, global.player.y];
				move_towards_point(global.player.x, global.player.y, dynamic_movement_speed);
			}
			//else move away
			else{
		
				if(can_float){
					var dir_away_from_player = point_direction(global.player.x, global.player.y, x, y - (dynamic_movement_speed/2));
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
				}
				else{
					var dir_away_from_player = point_direction(global.player.x, global.player.y, x, y);
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
				}
		
			}
		}
		else if (tactic_state == E_ENEMY_TACTIC_STATE.MOVE_AWAY_TO_FLEE){
			//move away
			if(can_float){
				var dir_away_from_player = direction_to_point(global.player.x, global.player.y, x, y - (dynamic_movement_speed/2));
				var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
				var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
				goal_point = [goal_point_x, goal_point_y];
				move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
			}
			else{
				var dir_away_from_player = direction_to_point(global.player.x, global.player.y, x, y);
				var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
				var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
				goal_point = [goal_point_x, goal_point_y];
				move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
			}
		}
	}
	
	//if the enemy is roughly where they want to be, move them around a bit
	if(distance_to_point(array_get(goal_point, 0), array_get(goal_point, 1)) < goal_radius){
		is_at_distance_goal = true;
		
		/*TODO: move the enemy back and forth in some form once it is at it's point
		
		if(can_float){
			x = x + dsin(current_time * wander_freq) * wander_amp;
			y = y + dsin(current_time * wander_freq) * wander_amp;
		}
		else{
			y = y + dsin(current_time * wander_freq) * wander_amp;
		}
		*/
		
	}
	else{
		is_at_distance_goal = false;
	}
	
}

#endregion


#region Attack

	#region Spawn Attacks
	
	attack_timer++;

	//if it is time to attack
	if(attack_timer >= attack_rate){
		
		//if in melee range, make melee attack
		if(distance_to_object(obj_player) <= melee_attack_range){
			show_debug_message("spawn melee attack");
			attack_timer = 0;
			melee_weapon = instance_create_layer(x, y, "Instances", obj_melee_weapon_enemy)
			melee_weapon.owner = self;
			melee_weapon.is_on = true;
		}
		//not in melee range, if can shoot, then shoot
		else{
		
			if(can_shoot){
				attack_timer = 0;
				//TODO:shoot
				show_debug_message("TODO:shoot");
			}
			else{
				show_debug_message("cannot shoot. and out of melee range");
			}
		}
	}
	#endregion


#endregion



#region Take Damage

if(place_meeting(x, y, obj_light)){
	show_debug_message("shadow collision with lantern");
	dynamic_hp = dynamic_hp - global.player.lantern.intensity;
}

if(place_meeting(x, y, obj_light_beam)){
	show_debug_message("shadow collision with light beam");
	dynamic_hp = dynamic_hp - global.player.beam.intensity;
}


#endregion


#region Death

if(variable_instance_exists(id, "dynamic_hp")){
	if(dynamic_hp <= 0){
		show_debug_message("shadow " + string(id) + " death.");
		instance_destroy();
	}
}


#endregion

