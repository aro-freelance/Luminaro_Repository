/// @description enemy of type E_ENEMY_TYPE.SMALL


// Inherit the parent event
event_inherited();

#region Sprite

image_xscale = .75;
image_yscale = .75;

#endregion


#region Enemy State

tactic_state = E_ENEMY_TACTIC_STATE.CHASE;

#endregion


#region static parameters

enemy_type = E_ENEMY_TYPES.SMALL;

static_movement_speed = 3;

melee_attack_range = 200;

can_float = true;

can_shoot = true;

ranged_attack_range = 500;

attack_rate = 800;

hp = 100;

level = 1;

#endregion

