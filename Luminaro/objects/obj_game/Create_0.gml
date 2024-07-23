/// @description this controls the game


#region Inputs


//TODO: put controls here and convert to using left instead of vk_left / "A" etc



#endregion





#region Game Parameters

enum E_GAME_STATE{
	MAIN_MENU,
	PLAYING,
	IN_GAME_MENU,
}

global.game_state = E_GAME_STATE.MAIN_MENU;

global.player = noone;

global.player_menu = noone;

global.lighting_effects = noone;


#endregion

#region World Parameters

global.grav = 4;

global.darkness_level = .7; //alpha value of obj_lighting_effect

#endregion

#region Button Inputs

enum E_BUTTON_HELD{
	NONE,
	LEFT, 
	RIGHT,
	FIRE,
	JUMP,
	CROUCH,
}

global.button_held = E_BUTTON_HELD.NONE;

global.button_held_time = 0;
global.button_held_threshold = 20;

#endregion

#region UI

distance_between_player_and_camera_bottom = display_get_gui_height()/10;

margin = 20;

#region HP / BATTERY / XP Bars


hp_bar_width = 600;
hp_bar_height = 50;


hp_bar_x1 = display_get_gui_width() - margin - hp_bar_width;
hp_bar_x2 = hp_bar_x1 + hp_bar_width;

hp_bar_y1 = margin;
hp_bar_y2 = hp_bar_y1 + hp_bar_height;


battery_bar_width = 600;
battery_bar_height = 50;
battery_bar_color = c_green; //uncharged color is in draw gui

battery_bar_x1 = display_get_gui_width() - margin - battery_bar_width;
battery_bar_x2 = battery_bar_x1 + battery_bar_width;

battery_bar_y1 = display_get_gui_height() - margin - battery_bar_height;
battery_bar_y2 = battery_bar_y1 + battery_bar_height;


xp_bar_width = 400;
xp_bar_height = 30;

xp_bar_x1 = margin;
xp_bar_x2 = xp_bar_x1 + xp_bar_width;

xp_bar_y1 = margin;
xp_bar_y2 = xp_bar_y1 + xp_bar_height;

#endregion


#region In Game Menu

enum E_PLAYER_MENU_STATE{
	DISPLAY_STATS,
	LEVEL_UP,
	SETTINGS,
	SAVE_LOAD_EXIT,
}


#endregion



#endregion

#region Objects

enum E_SOLID_OBJ_TYPE{
	NONE,
	FLOOR,
	WALL,
	last
}

enum E_PICKUP_TYPES{
	MESSAGE,
	HEALTH,
	XP,
	last
}

#endregion

#region Player

#region player states

enum E_JUMP_STATE{
	GROUNDED,
	JUMPING,
	FALLING,
}

enum E_STANDING_STATE{
	STANDING,
	CROUCHING,
	PRONE,
}

enum E_ATTACK_STATE{
	idle,
	beam,
	prism,
}

enum E_REACT_STATE{
	idle,
	getting_hit,
}

enum E_FACING{
	left,
	right,
}

#endregion



#region parameters baseline

//the parameters to display and which can be upgraded
enum E_PLAYER_PARAMETERS{
	MOVEMENT_SPEED,
	JUMP_HEIGHT,
	//JUMP_NUMBER,
	JUMP_FLOAT_TIME,
	BEAM_SPEED,
	BEAM_INTENSITY_MOD,
	//MAX_MIRRORS,
	PRISM_BEAM_NUMBER,
	BATTERY,
	BATTERY_CHARGE_DELAY,
	LANTERN_SIZE_MOD,
	BEAM_LENGTH_MOD,
	CATALYST_NUMBER,
	CATALYST_CHARGE_DELAY,
	CATALYST_SIZE_MOD,
	HP,
	last,
}



global.baseline_movement_speed = 15; //20
global.baseline_jump_height = 120; //150
//global.baseline_jump_number = 1; //2  //How many jumps the player can make
global.baseline_jump_float_time = 10; //12 //how long after jump does player hover


global.baseline_beam_speed = .025; //.03
global.baseline_light_intensity_mod = 1; //1.2

//how many mirrors can player have?
//global.baseline_max_mirrors = 1; //3

global.baseline_prism_beam_number = 3; //4


global.baseline_battery = 200; //250 //battery max on time
global.baseline_battery_charge_delay = 200; //150 //how long does the battery take to charge?
 
 
global.baseline_lantern_size_mod = 1; //the multiplier applied to the lantern size


global.baseline_beam_length_mod = 1; //the multiplier applied to beam length


global.baseline_catalyst_number = 2; //how many catalysts can be held max
global.baseline_catalyst_charge_delay = 500; //how long does a catalyst take to charge?
global.baseline_catalyst_size_mod = 1; //the multiplier applied to the catalyst size
 

global.baseline_hp = 100; //300

#endregion



#region stats per upgrade

global.d_movement_speed = 1; 
global.d_jump_height = 10; 
//global.d_jump_number = 1; 
global.d_jump_float_time = .5;


global.d_beam_speed = .005; 
global.d_light_intensity_mod= .1;

//how many mirrors can player have?
//global.d_max_mirrors = 1; //3

global.d_prism_beam_number = 1; 


global.d_battery = 50;
global.d_battery_charge_delay = -20;

global.d_lantern_size_mod = .1;

global.d_beam_length_mod = .1;

global.d_catalyst_number = 1;
global.d_catalyst_charge_delay = -20;
global.d_catalyst_size_mod = .1;

global.d_hp = 50; //300

#endregion



#endregion



#region Enemies

enum E_ENEMY_TYPES{
	BASIC,
	TINY,
	SMALL,
	BIG,
	TALL,
	last,
}

enum E_BOSS_TYPES{
	BOSS_1,
	BOSS_2,
	last,
}


enum E_ENEMY_JUMP_STATE{
	GROUNDED,
	JUMPING,
	FALLING,
	FLOATING,
}

enum E_ENEMY_STANDING_STATE{
	STANDING,
	CROUCHING,
	PRONE,
}

enum E_ENEMY_ATTACK_STATE{
	IDLE,
	MELEE,
	RANGED
}

enum E_ENEMY_REACT_STATE{
	IDLE,
	GETTING_HIT
}

enum E_ENEMY_TACTIC_STATE{
	CHASE,
	KEEP_DISTANCE,
	MOVE_AWAY_TO_SHOOT,
	MOVE_AWAY_TO_FLEE,
	//TODO: move to heal -> make the enemy move to a shadow and heal? wihle it is healing the spawn rate is lower?
}


//the list of current enemies spawned
global.enemy_list = ds_list_create();


#endregion

#region Shadows

enum E_SHADOW_STATE{
	DEACTIVATED, //light is hitting the shadow
	CHARGING, //no light is hitting but not spawning yet
	SPAWNING, //spawning enemies
	SUPERCHARGED, //spawning super enemies
}

enum E_SHADOW_TYPE{
	PUDDLE,
	WALL,
	CEILING,
	CORNER,
}

//in relation to the shadow placement, where should the shadows spawn?
//this is a solution to the issue of spawning shadow mobs in the floor / wall. 
//TODO: alternately we could move them out of the wall if they are in the wall using a block in their step code?
enum E_SHADOW_SPAWN_ORIENTATION{
	top_left,
	top_center,
	top_right,
	center_left,
	center,
	center_right,
	bottom_left,
	bottom_center,
	bottom_right,
	
}

#endregion

#region Light

enum E_LIGHT_TYPES{
	PLAYER_LANTERN, 
	PLAYER_BEAM,
	PLAYER_PRISM_BEAM, 
	MIRROR_BEAM, 
}

enum E_LIGHT_SIZE{
	NORMAL,
	NARROW,
	WIDE
}

#endregion


