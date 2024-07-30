/// @description enemy of type E_ENEMY_TYPE.BOSS_1


// Inherit the parent event
event_inherited();

#region Sprite

image_xscale = 1.6;
image_yscale = 1.6;

#endregion


#region Enemy State

tactic_state = E_ENEMY_TACTIC_STATE.CHASE;

#endregion


#region static parameters

enemy_type = E_BOSS_TYPES.BOSS_2;

static_movement_speed = 3.5;

melee_attack_range = 100;

can_float = true;

can_shoot = true;

ranged_attack_range = 350;

attack_rate = 200;

hp = 3000;

level = 2;

#endregion


