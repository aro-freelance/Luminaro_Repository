/// @description this controls the game

#region Game Parameters

enum E_GAME_STATE{
	MAIN_MENU,
	PLAYING,
}

global.game_state = E_GAME_STATE.MAIN_MENU;

global.player = noone;

#endregion

#region World Parameters

global.grav = 2;

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

#region Objects

enum E_SOLID_OBJ_TYPE{
	NONE,
	FLOOR,
	WALL,
	last
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
	lantern,
	beam,
}

#endregion

