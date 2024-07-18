/// @description enemy melee class. 
//this is used to make a reaching attack toward the player that grows in size 


depth = -21;

#region Sprite

sprite_subimage = 0;
x_scale = 1;
y_scale = 1;
sprite_rotation = 0;
sprite_color = c_white;
sprite_alpha = 1;

#endregion

init = false;

intensity = 20;

is_on = false;

owner = noone;

growth_factor = .2;

player_location_snapshot = [0, 0];

distance_to_player = 0;

//scale_distance_ratio = 1;