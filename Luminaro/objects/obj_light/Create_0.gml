/// @description basic light class (the player "weapon")

//draw behind player
depth = -9;



//the actor holding the light
holder = noone;


is_on = false;

is_colliding = false;


light_type = E_LIGHT_TYPES.PLAYER_LANTERN;
intensity = .5;
size = E_LIGHT_SIZE.NORMAL;
hold_distance = 30; // how far ahead of player is the weapon held?

xscale_growth = .01;
min_xscale = .4;
max_xscale = 2;



xEnd = 0;
yEnd = 0;

bounce_beam1 = noone;
bounce_beam2 = noone;
bounce_beam3 = noone;
bounce_beam4 = noone;
bounce_beam5 = noone;

bounce_point = [0, 0];



can_bounce = false;

//how many times can it bounce
bounce_number = 1;

//how many times has it bounced
bounce_counter = 0;

//what percent of intensity does a bounce get?
bounce_damage_mod = .75;

//what percent of intensity does a prism beam get?
prism_damage_mod = .50;