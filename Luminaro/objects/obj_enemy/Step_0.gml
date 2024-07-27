
if(global.game_state == E_GAME_STATE.PLAYING){

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
		image_blend = c_blue;
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
	if(dynamic_can_shoot) distance_goal = dynamic_ranged_attack_range - 20;
	else distance_goal = dynamic_melee_attack_range - 20;


}

#endregion

#region Sprite Index

//handle all sprite changes using states here

//store previous sprite so we can compare to see if the sprite changed
var prev_sprite_index = sprite_index;

var _spr = object_get_sprite(object_index); 
if (sprite_index != _spr)
{
    sprite_index = _spr;
	mask_index = _spr;
}

if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy;
}
else if(standing_state == E_ENEMY_STANDING_STATE.CROUCHING && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy_crouching;
}
/*
else if(standing_state == E_ENEMY_STANDING_STATE.PRONE && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy_prone;
}*/
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.JUMPING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy_jumping;
}
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.FALLING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy_falling;
}
else if(standing_state == E_ENEMY_STANDING_STATE.STANDING && jump_state == E_ENEMY_JUMP_STATE.FLOATING && attack_state == E_ENEMY_ATTACK_STATE.IDLE && react_state == E_ENEMY_REACT_STATE.IDLE){
	sprite_index = spr_enemy_floating;
}


//if sprite changed, set index to 0
if(sprite_index != prev_sprite_index) image_index = 0;


#endregion


#region Ground enemy / Fall

if(place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor"))){
	if(jump_state != E_ENEMY_JUMP_STATE.FLOATING) jump_state = E_ENEMY_JUMP_STATE.GROUNDED;
}
if(!place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor")) && jump_state == E_ENEMY_JUMP_STATE.GROUNDED && y != (room_height - sprite_height)){
	if(can_float){
		jump_state = E_ENEMY_JUMP_STATE.FLOATING;
	}
	else jump_state = E_JUMP_STATE.FALLING;	
}

#endregion


#region keep enemy on screen

//TODO: scroll the screen and make larger rooms?
/*
if(x < 0) x = 0;
if(x > (room_width - sprite_width)) x = room_width - sprite_width;
if(y < 0) y = 0;

//TODO: if player goes off the bottom of screen death?
if(y > (room_height - sprite_height)){
	y = room_height - sprite_height;
	if(jump_state != E_ENEMY_JUMP_STATE.FLOATING) jump_state = E_JUMP_STATE.GROUNDED;
}
*/

#endregion


#region gravity

if(jump_state != E_ENEMY_JUMP_STATE.GROUNDED){
	if(!place_meeting(x, y + global.grav, layer_tilemap_get_id("Tiles_Floor"))){
		if(!can_float) y = y + global.grav;
	}
}


//if not on the ground
if(jump_state != E_ENEMY_JUMP_STATE.GROUNDED && jump_state != E_ENEMY_JUMP_STATE.FLOATING){
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
			
			//move_contact_all(point_direction(x, y, global.player.x, global.player.y), dynamic_movement_speed);
		
		}
		else if(tactic_state == E_ENEMY_TACTIC_STATE.KEEP_DISTANCE || tactic_state == E_ENEMY_TACTIC_STATE.MOVE_AWAY_TO_SHOOT){
			//if too far, move closer
			if(distance_to_object(obj_player) > distance_goal){
				//goal_point = [global.player.x, global.player.y];
				move_towards_point(global.player.x, global.player.y, dynamic_movement_speed);
				
				//move_contact_all(point_direction(x, y, global.player.x, global.player.y), dynamic_movement_speed);
			}
			//else move away
			else if (distance_to_point(array_get(goal_point, 0), array_get(goal_point, 1)) > distance_goal){
		
				if(can_float){
					var dir_away_from_player = point_direction(global.player.x, global.player.y, x, y - (dynamic_movement_speed/2));
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player) , dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player) , dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
					
					
					
					
					//check if something is in the way of the original goal point
					if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Floor"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Floor");
						if(array_length(local_goal_point) == 2){
							var d = point_distance(global.player.x, global.player.y, array_get(goal_point, 0), array_get(goal_point, 1));
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff , dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff , dir_away_from_player);
						
							goal_point = [g_x, g_y];
							
							//show_debug_message("========================  original goal x = " + string(goal_point_x) + ". y = " + string(goal_point_y) + ". new x = " + string(g_x) + ". y = " + string(g_y) + ". d diff = " + string(d_diff)+ ". d = " + string(d) + ". distance goal = " + string(distance_goal));
						}
						//show_debug_message("enemy goal point: collision with floor");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Walls"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Walls");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with wall");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Ceiling"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Ceiling");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with ceiling");
					}
					
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
					
					//move_contact_all(point_direction(x, y, goal_point_x, goal_point_y), dynamic_movement_speed);
					
				}
				else{
					var dir_away_from_player = point_direction(global.player.x, global.player.y, x, y);
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
					
					//check if something is in the way of the original goal point
					if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Floor"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Floor");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with floor");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Walls"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Walls");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with wall");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Ceiling"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Ceiling");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with ceiling");
					}
					
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
					
					//move_contact_all(point_direction(x, y, goal_point_x, goal_point_y), dynamic_movement_speed);
					
				}
		
			}
			//else this enemy is at goal. start wandering
			else
			{
				//show_debug_message(string(self) + " is wandering. TODO: handle wander");
			}
			
		}
		else if (tactic_state == E_ENEMY_TACTIC_STATE.MOVE_AWAY_TO_FLEE){
			
			if (distance_to_point(array_get(goal_point, 0), array_get(goal_point, 1)) > distance_goal){
				//move away
				if(can_float){
					var dir_away_from_player = direction_to_point(global.player.x, global.player.y, x, y - (dynamic_movement_speed/2));
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
				
					//check if something is in the way of the original goal point
					if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Floor"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Floor");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with floor");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Walls"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Walls");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with wall");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Ceiling"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Ceiling");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with ceiling");
					}
				
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
				
					//move_contact_all(point_direction(x, y, goal_point_x, goal_point_y), dynamic_movement_speed);
				
				}
				else{
					var dir_away_from_player = direction_to_point(global.player.x, global.player.y, x, y);
					var goal_point_x = lengthdir_x(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					var goal_point_y = lengthdir_y(distance_goal - distance_to_object(obj_player), dir_away_from_player);
					goal_point = [goal_point_x, goal_point_y];
				
					//check if something is in the way of the original goal point
					if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Floor"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Floor");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with floor");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Walls"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Walls");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with wall");
					}
					else if(collision_line(x, y, goal_point_x, goal_point_y, layer_tilemap_get_id("Tiles_Ceiling"), false, false) != noone){
						var local_goal_point = scr_get_tm_collision_point(goal_point_x, goal_point_y, "Tiles_Ceiling");
						if(array_length(local_goal_point) == 2){
							var d_diff = point_distance(array_get(goal_point, 0), array_get(goal_point, 1), array_get(local_goal_point, 0), array_get(local_goal_point, 1));
							var g_x = lengthdir_x(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
							var g_y = lengthdir_y(distance_goal - distance_to_object(obj_player) - d_diff - goal_radius, dir_away_from_player);
						
							goal_point = [g_x, g_y];
						}
						//show_debug_message("enemy goal point: collision with ceiling");
					}
					
					move_towards_point(goal_point_x, goal_point_y, dynamic_movement_speed);
				
					//move_contact_all(point_direction(x, y, goal_point_x, goal_point_y), dynamic_movement_speed);
				
				}
			}
			//else this enemy is at goal. start wandering
			else
			{
				//show_debug_message(string(self) + " is wandering. TODO: handle wander");
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
		
		//show_debug_message("Enemy Step: Attack timer ready: distance goal = " + string(distance_goal) + ". current distance = " + string(distance_to_object(obj_player)) );
		
		//if in melee range, make melee attack
		if(distance_to_object(obj_player) <= melee_attack_range){
			tactic_state = E_ENEMY_TACTIC_STATE.KEEP_DISTANCE;
			//show_debug_message("spawn melee attack");
			attack_timer = 0;
			melee_weapon = instance_create_layer(x, y, "Weapons", obj_melee_weapon_enemy);
			melee_weapon.owner = self;
		}
		//not in melee range, if can shoot, then shoot
		else{
		
			if(can_shoot){
				tactic_state = E_ENEMY_TACTIC_STATE.KEEP_DISTANCE;
				attack_timer = 0;
				var projectile = instance_create_layer(x, y, "Weapons", obj_projectile_weapon_enemy);
				projectile.owner = self;
				
				ds_list_add(projectiles, projectile);
			}
			else{
				//show_debug_message("cannot shoot. and out of melee range");
				tactic_state = E_ENEMY_TACTIC_STATE.CHASE;
			}
		}
	}
	#endregion


#endregion



#region Death

if(variable_instance_exists(id, "dynamic_hp")){
	if(dynamic_hp <= 0){
		show_debug_message("shadow " + string(id) + " death.");
		
		randomize();
		var irand_health = irandom_range(0, 100);
		var irand_xp_offset = irandom_range(-100, 100);
		var irand_hp_offset = irandom_range(-100, 100) - irand_xp_offset;
		
		var irand_xp_variance = irandom_range(1, 1.3*level);
		
		var xp_pickup = instance_create_layer(x + irand_xp_offset, y, "Items", obj_xp_pickup);
		xp_pickup.amount *= irand_xp_variance;
		
		
		if(irand_health > 90) {
			var health_pickup = instance_create_layer(x + irand_hp_offset, y, "Items", obj_health_pickup);
			health_pickup.amount *= level;
		}
		
		//add self.enemy_type to the player's list of defeated enemies
		array_push(global.player.enemies_defeated, enemy_type);
		
		instance_destroy();
	}
}


#endregion


#region Bandaids


	#region Stuck
	
		if(x == xprevious && y == yprevious && distance_to_point(array_get(goal_point, 0), array_get(goal_point, 1)) < goal_radius){
			stuck_counter++;
		}
		
		//enemy is stuck for too long
		if(stuck_counter >= stuck_max_duration){
			//TODO: handle stuck enemy
			show_debug_message("TODO: handle stuck enemy");
		}
	
	#endregion

#endregion


}





