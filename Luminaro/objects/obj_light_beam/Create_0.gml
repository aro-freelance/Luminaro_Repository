/// @description light beam (the player "weapon")

// Inherit the parent event
event_inherited();


type = E_LIGHT_TYPES.PLAYER_BEAM;
intensity = .9;
size = E_LIGHT_SIZE.NORMAL;
hold_distance = 30; // how far ahead of player is the weapon held?


growth_deceleration = 0;
deceleration_rate = .00000001;

min_xscale = .4;
max_xscale = 1.2;



can_bounce = true;

//how many times can it bounce
bounce_number = 1;
