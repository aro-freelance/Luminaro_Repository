/// @description this controls the game


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

global.grav = 2.5;

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


