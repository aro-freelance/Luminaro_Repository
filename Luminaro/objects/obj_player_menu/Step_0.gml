
if(!init){
	init = true;
	
	//pause the game
	instance_deactivate_all(true);
	
	//unpause this.. TODO test without this?
	instance_activate_object(self);
	
	
	#region Level up
	
	show_debug_message("PRE level hp = " + string(global.player.hp));
	
	global.player.hp += 100;
	global.player.dynamic_hp = global.player.hp;
	
	show_debug_message("POST level hp = " + string(global.player.hp));
	
	//TODO: add to a random parameter?
	
	//TODO: add interface for letting player choose parameter to improve
	
	//TODO: handle multiple levels?
		
	#endregion

	
}

	
if(keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_f1)){
	global.game_state = E_GAME_STATE.PLAYING;
	instance_activate_all();
	//destroy this menu
	instance_destroy();
}