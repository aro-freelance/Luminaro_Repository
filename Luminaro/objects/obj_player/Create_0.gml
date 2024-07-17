/// @description create the player character


depth = -10; //draw in front of background


#region Player State 

enum E_JUMP_STATE{
	GROUNDED,
	JUMPING,
	FALLING,
}

jump_state = E_JUMP_STATE.GROUNDED;

enum E_STANDING_STATE{
	STANDING,
	CROUCHING,
	PRONE,
}

standing_state = E_STANDING_STATE.STANDING;

enum E_ATTACK_STATE{
	idle,
}

attack_state = E_ATTACK_STATE.idle;

enum E_REACT_STATE{
	idle,
	getting_hit,
}

react_state = E_REACT_STATE.idle;

#endregion


#region Static Player Parameters

static_movement_speed = 20;
static_jump_height = 100;
static_jump_number = 2; //How many jumps the player can make

#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;
dynamic_jump_height = static_jump_height;
dynamic_jump_number = static_jump_number; //How many jumps the player can make

jump_current = 0; //How many jumps the player has remaining

#endregion