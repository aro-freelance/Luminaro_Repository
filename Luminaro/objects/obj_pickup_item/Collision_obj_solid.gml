/// @description handle being inside a solid obj

if(global.game_state == E_GAME_STATE.PLAYING){

if(y > (other.y - sprite_get_height(other.sprite_index))){
	y -= 5;
	//show_debug_message("pickup in solid. y = " + string(y));
}

if(x > (other.x - sprite_get_width(other.sprite_index))){
	x -= 5;
	//show_debug_message("pickup in solid. x = " + string(x));
}

if(x < (other.x + sprite_get_width(other.sprite_index))){
	x += 5;
	//show_debug_message("pickup in solid. x = " + string(x));
}


}