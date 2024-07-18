/// @description light beam (the player "weapon")


//draw behind player
depth = -9;

type = E_LIGHT_TYPES.beam;
intensity = .9;

sprite_subimage = 0;
sprite_x_scale = 1;
sprite_y_scale = 1;
sprite_rotation = 0;
sprite_color = c_white;
sprite_alpha = 1;



//the actor holding the light
holder = noone;

is_on = false;
