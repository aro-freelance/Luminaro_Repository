/// @description create the player character


depth = -10; //draw in front of background

global.game_state = E_GAME_STATE.PLAYING;

global.player = self;

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
static_jump_float_time = 12; //how long after jump does player hover

//how many mirrors can player have?
max_mirrors = 3;

prism_beam_number = 3;

hp = 100;

//TODO: get from save?
xp = 0;

#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;

dynamic_jump_height = static_jump_height;
dynamic_jump_number = static_jump_number; //How many jumps the player can make
dynamic_jump_float_time = static_jump_float_time //how long after jump does player hover
jump_float_counter = 0; //how long has player been floating? (compared to dynamic_jump_float_tme)

dynamic_max_mirrors = max_mirrors;

dynamic_prism_beam_number = prism_beam_number;

jump_current = 0; //How many jumps the player has used (compared to dynamic_jump_number to determine if player is allowed to jump)

dynamic_hp = hp;

#endregion


#region Light


lantern = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light);
lantern.light_type = E_LIGHT_TYPES.PLAYER_LANTERN;
lantern.holder = self;
lantern.is_on = true;


beam = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light_beam);
beam.light_type = E_LIGHT_TYPES.PLAYER_BEAM;
beam.holder = self;
beam.is_on = false;

prism_beams = ds_list_create();
prism_max_angle = 160;


#endregion


#region Mirrors

//list of mirrors dropped
mirrors = [];


#endregion