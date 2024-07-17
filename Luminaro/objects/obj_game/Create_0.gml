/// @description this controls the game


enum E_GAME_STATE{
	MAIN_MENU,
	PLAYING,
}

global.game_state = E_GAME_STATE.MAIN_MENU;

global.player = noone;

global.grav = 2;



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




enum E_SOLID_OBJ_TYPE{
	NONE,
	FLOOR,
	WALL,
}

