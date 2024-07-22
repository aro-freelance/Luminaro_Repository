/// @description basic shadow object

//show_debug_message("create shadow");

depth = -8;


shadow_state = E_SHADOW_STATE.DEACTIVATED;
shadow_type = E_SHADOW_TYPE.PUDDLE;

level = 1;

hp = 200;



//timer until spawning starts (when in charging state)
charge_timer = 0;
charge_rate = 500;

//timer until next spawn (when in spawning state)
spawn_timer = 0;
spawn_rate = 2000;

//timer until supercharged (when in spawning state)
supercharge_timer = 0;
supercharge_rate = 8000;
supercharged = false;


