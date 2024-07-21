/// @description basic enemy projectile class



depth = -21;

#region Weapon Identity and Init

owner = noone;

init = false;

is_on = false;

#endregion

#region Weapon Properties

intensity = 20;

growth_factor = .2;

movement_speed = 12;

can_bounce = true;

//how many times can it bounce
bounce_number = 1;

//how many times has it bounced
bounce_counter = 0;

#endregion

#region player information at spawn

player_location_snapshot = [0, 0];

distance_to_player = 0;

#endregion
