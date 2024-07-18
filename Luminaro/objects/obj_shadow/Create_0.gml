/// @description basic shadow object

show_debug_message("create shadow");

depth = -8;

sprite_subimage = 0;
sprite_x_scale = 1;
sprite_y_scale = 1;
rotation = 0;
sprite_color = c_white;
sprite_alpha = 1;


shadow_state = E_SHADOW_STATE.DEACTIVATED;
shadow_type = E_SHADOW_TYPE.PUDDLE;


//timer until spawning starts (when in charging state)
charge_timer = 0;
charge_rate = 500;

//timer until next spawn (when in spawning state)
spawn_timer = 0;
spawn_rate = 500;

//timer until supercharged (when in spawning state)
supercharge_timer = 0;
supercharge_rate = 2500;
supercharged = false;


