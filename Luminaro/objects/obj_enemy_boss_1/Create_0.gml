/// @description enemy of type E_ENEMY_TYPE.BOSS_1


// Inherit the parent event
event_inherited();

#region Sprite

sprite_x_scale = 1.6;
sprite_y_scale = 1.6;

#endregion


#region Enemy State

tactic_state = E_ENEMY_TACTIC_STATE.CHASE;

#endregion


#region static parameters

static_movement_speed = 3;

melee_attack_range = 600;

can_float = true;

can_shoot = true;

ranged_attack_range = 800;

attack_rate = 800;

hp = 100;

level = 1;

#endregion


