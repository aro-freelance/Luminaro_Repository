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
static_jump_height = 150;
static_jump_number = 2; //How many jumps the player can make
static_jump_float_time = 12; //how long after jump does player hover

fall_acceleration = 1.1;
run_acceleration = 1.5;

//how many mirrors can player have?
max_mirrors = 3;

prism_beam_number = 3;

hp = 300;

//TODO: get from save?
xp = 0;

#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;

dynamic_jump_height = static_jump_height;
dynamic_jump_number = static_jump_number; //How many jumps the player can make
dynamic_jump_float_time = static_jump_float_time //how long after jump does player hover
jump_float_counter = 0; //how long has player been floating? (compared to dynamic_jump_float_tme)

x_speed = 0;
y_speed = 0;

dynamic_max_mirrors = max_mirrors;

dynamic_prism_beam_number = prism_beam_number;

jump_current = 0; //How many jumps the player has used (compared to dynamic_jump_number to determine if player is allowed to jump)

dynamic_hp = hp;

#endregion


#region Light


lantern = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Weapons", obj_light);
lantern.light_type = E_LIGHT_TYPES.PLAYER_LANTERN;
lantern.holder = self;
lantern.is_on = true;


beam_holding_height = 3*sprite_get_height(sprite_index)/4;
beam = instance_create_layer(x, y - beam_holding_height, "Weapons", obj_light_beam);
beam.light_type = E_LIGHT_TYPES.PLAYER_BEAM;
beam.holder = self;
beam.is_on = false;


prism_beams = ds_list_create();
prism_max_angle = 140;


#endregion


#region battery


on_timer = 0; //drain battery counter
battery = 250; //battery max on time

battery_charge_timer = 0; //battery charge counter
battery_charge_delay = 150; //how long does the battery take to charge?
battery_charged = true; //is the battery ready?

#endregion



#region Mirrors

//list of mirrors dropped
mirrors = [];


#endregion