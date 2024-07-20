/// @description enemy of type E_ENEMY_TYPE.TALL


// Inherit the parent event
event_inherited();

#region Sprite

image_xscale = 1.5;
image_yscale = .8;

#endregion


#region Enemy State

tactic_state = E_ENEMY_TACTIC_STATE.CHASE;

#endregion


#region static parameters

enemy_type = E_ENEMY_TYPES.TALL;

static_movement_speed = 3;

melee_attack_range = 400;

can_float = true;

can_shoot = false;

ranged_attack_range = 500;

attack_rate = 800;

hp = 100;

level = 1;

#endregion

