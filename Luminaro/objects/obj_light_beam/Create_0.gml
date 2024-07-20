/// @description light beam (the player "weapon")

// Inherit the parent event
event_inherited();


type = E_LIGHT_TYPES.PLAYER_BEAM;
intensity = .9;
size = E_LIGHT_SIZE.NORMAL;
hold_distance = 30; // how far ahead of player is the weapon held?



xscale_growth = .01;
min_xscale = .4;
max_xscale = 2;

#region battery


on_timer = 0; //drain battery counter
battery = 250; //battery max on time

battery_charge_timer = 0; //battery charge counter
battery_charge_delay = 150; //how long does the battery take to charge?
battery_charged = true; //is the battery ready?

#endregion

can_bounce = true;

//how many times can it bounce
bounce_number = 1;
