/// @description basic light class (the player "weapon")

//draw behind player
depth = -9;

show_debug_message("light created");

//the actor holding the light
holder = noone;


is_on = false;

is_colliding = false;


light_type = E_LIGHT_TYPES.PLAYER_LANTERN;

size = E_LIGHT_SIZE.NORMAL;
hold_distance = 80; // how far ahead of player is the weapon held?

x_offset = 0;
y_offset = 0;

intensity = .8;
xscale_growth = .01;
min_xscale = .4;
max_xscale = 2;



xEnd = 0;
yEnd = 0;


can_bounce = false;

//how many times can it bounce
bounce_number = 1;

//how many times has it bounced
bounce_counter = 0;

//what percent of intensity does a bounce get?
bounce_damage_mod = 1.3;

//what percent of intensity does a prism beam get?
prism_damage_mod = .80;





