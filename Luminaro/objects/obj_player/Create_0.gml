/// @description create the player character


depth = -10; //draw in front of background

global.game_state = E_GAME_STATE.PLAYING;

#region Player State 

jump_state = E_JUMP_STATE.GROUNDED;

standing_state = E_STANDING_STATE.STANDING;

attack_state = E_ATTACK_STATE.idle;

react_state = E_REACT_STATE.idle;

facing = E_FACING.right;

#endregion


#region Static Player Parameters

static_movement_speed = 20;
static_jump_height = 100;
static_jump_number = 2; //How many jumps the player can make

//how many mirrors can player have?
max_mirrors = 3;

hp = 1000;

//TODO: get from save?
xp = 0;

#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;
dynamic_jump_height = static_jump_height;
dynamic_jump_number = static_jump_number; //How many jumps the player can make

dynamic_max_mirrors = max_mirrors;

jump_current = 0; //How many jumps the player has remaining

dynamic_hp = hp;

#endregion


#region Light


lantern = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light);
lantern.light_type = E_LIGHT_TYPES.LANTERN;
lantern.holder = self;
lantern.is_on = true;


beam = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light_beam);
beam.light_type = E_LIGHT_TYPES.BEAM;
beam.holder = self;
beam.is_on = false;



#endregion


#region Mirrors

//list of mirrors dropped
mirrors = [];


#endregion