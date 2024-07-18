/// @description create the player character


depth = -10; //draw in front of background


#region Player State 

jump_state = E_JUMP_STATE.GROUNDED;

standing_state = E_STANDING_STATE.STANDING;

attack_state = E_ATTACK_STATE.idle;

react_state = E_REACT_STATE.idle;

#endregion


#region Static Player Parameters

static_movement_speed = 20;
static_jump_height = 100;
static_jump_number = 2; //How many jumps the player can make

hp = 100;

#endregion


#region Dynamic Player Parameters

dynamic_movement_speed = static_movement_speed;
dynamic_jump_height = static_jump_height;
dynamic_jump_number = static_jump_number; //How many jumps the player can make

jump_current = 0; //How many jumps the player has remaining

dynamic_hp = hp;

#endregion


#region Light


lantern = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light);
lantern.holder = self;
lantern.is_on = true;

beam = instance_create_layer(x, y - sprite_get_height(sprite_index)/2, "Instances", obj_light_beam);
type = E_LIGHT_TYPES.beam;
beam.holder = self;
beam.is_on = false;

#endregion