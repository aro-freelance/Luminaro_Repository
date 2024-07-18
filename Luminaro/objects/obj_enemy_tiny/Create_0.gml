/// @description enemy of type E_ENEMY_TYPE.TINY

show_debug_message("create ENEMY TINY");

depth = -20;

#region Sprite

sprite_x_scale = .5;
sprite_y_scale = .5;
sprite_subimage = 0;
sprite_color = c_white;

#endregion


#region Enemy State

jump_state = E_ENEMY_JUMP_STATE.GROUNDED;

standing_state = E_ENEMY_STANDING_STATE.STANDING;

attack_state = E_ENEMY_ATTACK_STATE.IDLE;

react_state = E_ENEMY_REACT_STATE.IDLE;

tactic_state = E_ENEMY_TACTIC_STATE.CHASE;


can_move = false;
can_attack = false;


#endregion


#region static parameters

static_movement_speed = 3;

melee_attack_range = 200;

can_float = true;

can_shoot = false;

ranged_attack_range = 0;

attack_rate = 800;

hp = 100;

#endregion


#region dynamic parameters

parameter_init = false;

dynamic_movement_speed = 0;

dynamic_melee_attack_range = 0;

dynamic_can_float = 0;

dynamic_can_shoot = 0;

dynamic_ranged_attack_range = 0;

dynamic_attack_rate = 0;

dynamic_hp = 0;

#endregion


#region tactics information 

//what distance does the enemy want to be from the player?
distance_goal = room_width; //set in parameter_init block in step

goal_point = [0, 0];

goal_radius = 150;


wander_amp = 400;
wander_freq = 100;

is_at_distance_goal = false;

attack_timer = 0;

#endregion


#region supercharge

supercharged_initiated = false;
supercharged = false;

#endregion