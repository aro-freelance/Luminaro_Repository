/// @description basic enemy projectile class




#region Sprite

depth = -21;

sprite_subimage = 0;
x_scale = 1;
y_scale = 1;
sprite_rotation = 0;
sprite_color = c_white;
sprite_alpha = 1;

#endregion

#region Weapon Identity and Init

owner = noone;

init = false;

is_on = false;

#endregion

#region Weapon Properties

intensity = 20;

growth_factor = .2;

movement_speed = 12;

can_bounce = false;

//how many times can it bound
bounce_number = 1;

//how many times has it bounced
bounce_counter = 0;

#endregion

#region player information at spawn

player_location_snapshot = [0, 0];

distance_to_player = 0;

#endregion
