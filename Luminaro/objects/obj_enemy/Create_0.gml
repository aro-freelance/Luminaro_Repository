/// @description base enemy class


depth = -20;



#region Enemy State


jump_state = E_ENEMY_JUMP_STATE.GROUNDED;

standing_state = E_ENEMY_STANDING_STATE.STANDING;

attack_state = E_ENEMY_ATTACK_STATE.IDLE;

react_state = E_ENEMY_REACT_STATE.IDLE;

tactic_state = E_ENEMY_TACTIC_STATE.KEEP_DISTANCE;


can_move = false;
can_attack = false;


#endregion


#region static parameters

enemy_type = E_ENEMY_TYPES.BASIC;

static_movement_speed = 3;

melee_attack_range = 400;

can_float = true;

can_shoot = true;

ranged_attack_range = 700;

attack_rate = 800;

hp = 100;

level = 1;

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
distance_goal = 100; //set in parameter_init block in step

goal_point = [0, 0];

goal_radius = 150;


wander_amp = 400;
wander_freq = 100;

is_at_distance_goal = false;

attack_timer = 400; //first shot is faster

#endregion


#region supercharge

supercharged = false;

#endregion


#region weapons

melee_weapon = noone;

projectiles = ds_list_create();

#endregion

