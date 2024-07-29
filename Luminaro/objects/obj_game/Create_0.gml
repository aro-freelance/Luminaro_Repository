/// @description this controls the game



init = false;

#region Inputs


//TODO: put controls here and convert to using left instead of vk_left / "A" etc



#endregion

#region Game Parameters

enum E_GAME_STATE{
	MAIN_MENU,
	PLAYING,
	IN_GAME_MENU,
	LEVEL_TRANSITION,
	WIN_SCREEN,
	DEATH_SCREEN,
}

global.game_obj = self;

global.game_state = E_GAME_STATE.MAIN_MENU;

global.current_level = E_LEVELS.LEVEL_1;

global.start_room = rm_level1;

global.player = noone;

global.player_menu = noone;

global.lighting_effects = noone;


#endregion

#region World Parameters


//starting base amount
global.grav = 6;

//terminal velocity
global.terminal_velocity = 13;

//starting acceleration
global.starting_grav_a = 0.0001;
global.grav_acceleration = global.starting_grav_a; //note that this value is changed during use and is then reset to starting_grav_a in player step

//increase in acceleration per tick
global.grav_delta_a = 1.05;

//gravity formula: grav + grav_a(delta_a)  -> clamped to terminal velocity


global.darkness_level = .7; //alpha value of obj_lighting_effect

#endregion

#region Levels

enum E_LEVELS{
	LEVEL_1,
	LEVEL_2,
	last
}

global.levels = [];
array_insert(global.levels, E_LEVELS.LEVEL_1, rm_level1);
array_insert(global.levels, E_LEVELS.LEVEL_2, rm_level2);

#endregion



#region UI

global.dg_width = display_get_gui_width();
global.dg_height = display_get_gui_height();

distance_between_player_and_camera_bottom = global.dg_height/4;

margin = 20;

#region HP / BATTERY / XP Bars


hp_bar_width = 600;
hp_bar_height = 50;


hp_bar_x1 = global.dg_width - margin - hp_bar_width;
hp_bar_x2 = hp_bar_x1 + hp_bar_width;

hp_bar_y1 = margin;
hp_bar_y2 = hp_bar_y1 + hp_bar_height;


battery_bar_width = 600;
battery_bar_height = 50;
battery_bar_color = c_green; //uncharged color is in draw gui

battery_bar_x1 = global.dg_width - margin - battery_bar_width;
battery_bar_x2 = battery_bar_x1 + battery_bar_width;

battery_bar_y1 = global.dg_height - margin - battery_bar_height;
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
	INVENTORY,
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
	last_before_perm,
	UPGRADE,
	INVENTORY,
	last
}


enum E_INVENTORY_ITEM_TYPES{
	TYPE_0,	
	TYPE_1,
	TYPE_2,
	TYPE_3,
	TYPE_4,
	TYPE_5,
	TYPE_6,
	TYPE_7,
	last
}


global.item_descriptions_short = [];

array_insert(global.item_descriptions_short, E_INVENTORY_ITEM_TYPES.TYPE_0, "Flamestone.");
array_insert(global.item_descriptions_short, E_INVENTORY_ITEM_TYPES.TYPE_1, "Mythril.");
array_insert(global.item_descriptions_short, E_INVENTORY_ITEM_TYPES.TYPE_2, "Fire Mythril.");

global.item_descriptions = [];

array_insert(global.item_descriptions, E_INVENTORY_ITEM_TYPES.TYPE_0, "Flamestone. Light intensity + 1 ");
array_insert(global.item_descriptions, E_INVENTORY_ITEM_TYPES.TYPE_1, "Mythril. Catalyst size + 1 ");
array_insert(global.item_descriptions, E_INVENTORY_ITEM_TYPES.TYPE_2, "Fire Mythril. Light intensity + 2, Catalyst size + 2");


global.combine_descriptions = ds_grid_create(E_INVENTORY_ITEM_TYPES.last - 1, E_INVENTORY_ITEM_TYPES.last - 1);

global.combine_descriptions[# E_INVENTORY_ITEM_TYPES.TYPE_0, E_INVENTORY_ITEM_TYPES.TYPE_0] = "Flamestone";
global.combine_descriptions[# E_INVENTORY_ITEM_TYPES.TYPE_1, E_INVENTORY_ITEM_TYPES.TYPE_1] = "Mythril";
global.combine_descriptions[# E_INVENTORY_ITEM_TYPES.TYPE_2, E_INVENTORY_ITEM_TYPES.TYPE_2] = "Fire Mythril";


global.combine_descriptions[# E_INVENTORY_ITEM_TYPES.TYPE_0, E_INVENTORY_ITEM_TYPES.TYPE_1] = "Fire Mythril";
global.combine_descriptions[# E_INVENTORY_ITEM_TYPES.TYPE_1, E_INVENTORY_ITEM_TYPES.TYPE_0] = "Fire Mythril";

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
	WALKING,
	CROUCHING,
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
	last,
}



global.baseline_movement_speed = 8; //20
global.baseline_jump_height = 200; //150
//global.baseline_jump_number = 1; //2  //How many jumps the player can make
global.baseline_jump_float_time = .27; //12 //how long after jump does player hover


global.baseline_beam_speed = .025; //.03
global.baseline_light_intensity_mod =  3; //1; //1.2

//how many mirrors can player have?
//global.baseline_max_mirrors = 1; //3

global.baseline_prism_beam_number = 3; //4


global.baseline_battery =  1000; //3.555555;  //battery max on time
global.baseline_battery_charge_delay = 5; //150 //how long does the battery take to charge?
 
 
global.baseline_lantern_size_mod = 1; //the multiplier applied to the lantern size


global.baseline_beam_length_mod = 1.5; //the multiplier applied to beam length


global.baseline_catalyst_number = 2; //how many catalysts can be held max
global.baseline_catalyst_charge_delay = 10; //how long does a catalyst take to charge?
global.baseline_catalyst_size_mod = 1; //the multiplier applied to the catalyst size
 

global.baseline_hp = 5000; //100 

#endregion



#region stats per upgrade

global.d_movement_speed = 1; 
global.d_jump_height = 10; 
//global.d_jump_number = 1; 
global.d_jump_float_time = .01;


global.d_beam_speed = .005; 
global.d_light_intensity_mod = .5;

//how many mirrors can player have?
//global.d_max_mirrors = 1; //3

global.d_prism_beam_number = 1; 


global.d_battery = 1;
global.d_battery_charge_delay = -.5;

global.d_lantern_size_mod = .1;

global.d_beam_length_mod = .1;

global.d_catalyst_number = 1;
global.d_catalyst_charge_delay = -1;
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
	TALL,
	DIAMOND,
	CIRCLE,
	last
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


#region Story

//when creation code runs on level we will set the end story
current_boss_story = [];
current_end_story = [];

level_1_begin_story = [];
array_push(level_1_begin_story, "Your peaceful world has fallen to shadow!");
array_push(level_1_begin_story, "But there is hope still...");
array_push(level_1_begin_story, "A tale tells of hidden components spread throughout the world.");
array_push(level_1_begin_story, "When combined they will create the Luminaro which will bring light back to the world and banish the shadows.");
array_push(level_1_begin_story, "You have come to a small cave where you will find your first component.");
array_push(level_1_begin_story, "Delve into the cave and banish the shadow with your light!");
array_push(level_1_begin_story, " Movement: WASD or arrow keys \n Light Beam: Hold Left Mouse \n Explosive Catalyst: Right mouse \n Prism Beam: Middle Mouse \n Narrow Beam (increase damage): Q or Numberpad 1 \n Widen Beam (lower damage but more area): E or Numberpad 0 ");

level_1_boss_story = [];
array_push(level_1_boss_story, "You have found " + global.item_descriptions[0] + "!");

level_1_end_story = [];
array_push(level_1_end_story, "After finding " + global.item_descriptions_short[0] + " you leave in pursuit of the next component.");


level_2_begin_story = [];
array_push(level_2_begin_story, "You have found your way to the next component");
array_push(level_2_begin_story, "Delve into the cave and banish the shadow with your light!");


level_2_boss_story = [];
array_push(level_2_boss_story, "You have found " + global.item_descriptions_short[1] + "! \nYou now have two items which can be combined.");
array_push(level_2_boss_story, "Open the menu using F1 and then open the inventory. \nCombine " + global.item_descriptions_short[0] + " and " + global.item_descriptions_short[1] + " to create " + global.item_descriptions_short[2] + ".");


level_2_end_story = [];
array_push(level_2_end_story, "You have created " + global.item_descriptions_short[2] + " and you are well on your way to banishing the shadow!");
array_push(level_2_end_story, "This is the end of the version of the game completed for the Jam! The journey to defeat the shadow is still being written.");
array_push(level_2_end_story, "Thank you for playing!")




win_story = level_2_end_story;
//array_push(win_story, "Game Jam Version complete!")



#endregion
