/// @description causes explosion of light on collision with light source


is_exploding = false;

max_size = 100;

//the multiplier applied to the light intensity that hits this.  this needs  to be quite hit because the duration needs to be quick
intensity_modifier = 200;

//set on collision by applying intensity_modifier to the source light's intensity
damage = 0;

//how long does the explosion last? when explosion is done this obj is destroyed
explosion_duration = 60;


timer = 0;

//after it appears how long does it stay?
time_until_disappear = 1000;
