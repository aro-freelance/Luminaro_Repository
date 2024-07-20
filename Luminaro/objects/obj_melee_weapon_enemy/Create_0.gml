/// @description enemy melee class. 
//this is used to make a reaching attack toward the player that grows in size 


depth = -21;


init = false;

is_on = false;

owner = noone;

destroy_delay = 10;
destroy_counter = 0;


intensity = 20;

growth_factor = .2;



//the location of the player when this spawns
player_location_snapshot = [0, 0];

//the distance to the player when this spawns
distance_to_player = 0;

//the distance past the player at which to aim (i.e. punch through the target not at the target)
followthrough_distance = 80;

scale_distance_ratio = 1; //the max value y_scale will reach, to reach the endpoint (the player + followthrough distance)

