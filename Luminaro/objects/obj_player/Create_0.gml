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


#region Stat Levels

//how many times have parameters been improved? for each level in these parameters we apply d_stat to the baseline_stat

l_movement_speed = 0;
l_jump_height = 0;
l_jump_number = 0; 
l_jump_float_time = 0;

l_beam_speed = 0;
l_light_intensity_mod = 0;

//l_max_mirrors = 0;

l_prism_beam_number = 0;

l_battery = 0;
l_battery_charge_delay = 0;

l_lantern_size_mod = 0;

l_beam_length_mod = 0;

l_catalyst_number = 0;
l_catalyst_charge_delay = 0;
l_catalyst_size_mod = 0;

l_hp = 0;


#endregion



#region Static Player Parameters

//this is for unaltered stats (in case we add effects that temp lower them)
//these stats are built using the (baseline) added to (levels in a stat) multiplied by (amount to increase per level)

static_movement_speed = global.baseline_movement_speed + (l_movement_speed * global.d_movement_speed);

static_jump_height = global.baseline_jump_height + (l_jump_height * global.d_jump_height);
//static_jump_number = global.baseline_jump_number + (l_jump_number * global.d_jump_number); //How many jumps the player can make
static_jump_float_time = global.baseline_jump_float_time + (l_jump_float_time * global.d_jump_float_time); //how long after jump does player hover

static_beam_speed = global.baseline_beam_speed + (l_beam_speed * global.d_beam_speed);
static_light_intensity_mod = global.baseline_light_intensity_mod + (l_light_intensity_mod * global.d_light_intensity_mod);

//static_max_mirrors = global.baseline_max_mirrors + (l_max_mirrors * global.d_max_mirrors);

static_prism_beam_number = global.baseline_prism_beam_number + (l_prism_beam_number * global.d_prism_beam_number);


static_battery = global.baseline_battery + (l_battery * global.d_battery); //battery max on time
static_battery_charge_delay = global.baseline_battery_charge_delay + (l_battery_charge_delay * global.d_battery_charge_delay); //how long does the battery take to charge?


static_lantern_size_mod = global.baseline_lantern_size_mod + (l_lantern_size_mod * global.d_lantern_size_mod);

static_beam_length_mod = global.baseline_beam_length_mod + (l_beam_length_mod * global.d_beam_length_mod);

static_catalyst_number = global.baseline_catalyst_number + (l_catalyst_number * global.d_catalyst_number);
static_catalyst_charge_delay = global.baseline_catalyst_charge_delay + (l_catalyst_charge_delay * global.d_catalyst_charge_delay);
static_catalyst_size_mod = global.baseline_catalyst_size_mod + (l_catalyst_size_mod * global.d_catalyst_size_mod);


static_hp = global.baseline_hp + (l_hp * global.d_hp); //aka total hp


#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;

dynamic_jump_height = static_jump_height;
dynamic_jump_number = 2;  //static_jump_number; //How many jumps the player can make
dynamic_jump_float_time = static_jump_float_time //how long after jump does player hover


dynamic_beam_speed = static_beam_speed;
dynamic_light_intensity_mod = static_light_intensity_mod;

//dynamic_max_mirrors = static_max_mirrors;

dynamic_prism_beam_number = static_prism_beam_number;

dynamic_battery = static_battery;
dynamic_battery_charge_delay = static_battery_charge_delay;

dynamic_lantern_size_mod = static_lantern_size_mod;

dynamic_beam_length_mod = static_beam_length_mod;

dynamic_catalyst_number = static_catalyst_number;
dynamic_catalyst_charge_delay = static_catalyst_charge_delay;
dynamic_catalyst_size_mod = static_catalyst_size_mod;


dynamic_hp = static_hp; //aka current hp

//TODO: get from save?
xp = 0;


jump_current = 0; //How many jumps the player has used (compared to dynamic_jump_number to determine if player is allowed to jump)
jump_float_counter = 0; //how long has player been floating? (compared to dynamic_jump_float_tme)


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
prism_max_angle = 90;


#endregion


#region battery

on_timer = 0; //drain battery counter

battery_charge_timer = 0; //battery charge counter
battery_charged = true; //is the battery ready?

#endregion



#region Mirrors

//list of mirrors dropped
mirrors = [];


#endregion

#region Catalysts

catalyst_charge_timer = 0;
current_catalyst_charges = 0;

current_spawned_catalysts = 0;

#endregion