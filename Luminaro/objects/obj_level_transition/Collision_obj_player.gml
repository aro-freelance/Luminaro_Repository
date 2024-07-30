

global.game_state = E_GAME_STATE.LEVEL_TRANSITION;
instance_deactivate_all(true);

global.current_level++;
scr_level_transition(global.current_level);

instance_destroy();
