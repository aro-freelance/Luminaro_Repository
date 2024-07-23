
if(global.game_state == E_GAME_STATE.PLAYING){
	if(global.player != noone){
	
		//draw player health
		draw_healthbar(hp_bar_x1, hp_bar_y1, hp_bar_x2, hp_bar_y2, (global.player.dynamic_hp/global.player.static_hp) * 100, c_black, c_red, c_red, 0, true, true);
	
		
		//draw player battery bar
		if(!global.player.battery_charged) battery_bar_color = c_grey;
		else battery_bar_color = c_green;
		draw_healthbar(battery_bar_x1, battery_bar_y1, battery_bar_x2, battery_bar_y2, ((global.player.dynamic_battery - global.player.on_timer)/ global.player.dynamic_battery) * 100, c_black, battery_bar_color, battery_bar_color, 0, true, true);
	
		//draw player xp bar
		draw_healthbar(xp_bar_x1, xp_bar_y1, xp_bar_x2, xp_bar_y2, global.player.xp, c_black, c_yellow, c_yellow, 0, true, true);
	
	
	}
}
