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

can_bounce = false;

//how many times can it bounce
bounce_number = 1;

//how many times has it bounced
bounce_counter = 0;

//what percent of intensity does a bounce get?
bounce_damage_mod = .75;

//what percent of intensity does a prism beam get?
prism_damage_mod = .50;