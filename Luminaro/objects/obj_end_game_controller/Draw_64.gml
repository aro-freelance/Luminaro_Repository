
#region Draw Header

draw_set_font(fnt_1_large);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_text(display_width/2, display_height/12, "GAME OVER");

#endregion


#region Draw Stats

draw_set_font(fnt_1);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
		

		
draw_text(display_width/2 + 2*margin, y1 + (2*margin), "Movement Speed Upgrades: " + string(global.player.l_movement_speed));
draw_text(display_width/2 + 2*margin, y1 + (4*margin), "Jump Height Upgrades: " + string(global.player.l_jump_height));
draw_text(display_width/2 + 2*margin, y1 + (6*margin), "Jump Float Time Upgrades: " + string(global.player.l_jump_float_time));
draw_text(display_width/2 + 2*margin, y1 + (8*margin), "Beam Growth Speed Upgrades: " + string(global.player.l_beam_speed));
draw_text(display_width/2 + 2*margin, y1 + (10*margin), "Light Intensity Mod Upgrades: " + string(global.player.l_light_intensity_mod));
draw_text(display_width/2 + 2*margin, y1 + (12*margin), "Prism Beam Number Upgrades: " + string(global.player.l_prism_beam_number));
draw_text(display_width/2 + 2*margin, y1 + (14*margin), "Battery Max Upgrades: " + string(global.player.l_battery));
draw_text(display_width/2 + 2*margin, y1 + (16*margin), "Battery Charge Delay Upgrades: " + string(global.player.l_battery_charge_delay));
draw_text(display_width/2 + 2*margin, y1 + (18*margin), "Lantern Size Upgrades: " + string(global.player.l_lantern_size_mod));
draw_text(display_width/2 + 2*margin, y1 + (20*margin), "Beam Length Upgrades: " + string(global.player.l_beam_length_mod));
draw_text(display_width/2 + 2*margin, y1 + (22*margin), "Catalyst Number Upgrades: " + string(global.player.l_catalyst_number));
draw_text(display_width/2 + 2*margin, y1 + (24*margin), "Catalyst Charge Delay Upgrades: " + string(global.player.l_catalyst_charge_delay));
draw_text(display_width/2 + 2*margin, y1 + (26*margin), "Catalyst Size Mod Upgrades: " + string(global.player.l_catalyst_size_mod));
		
		
draw_text(x1 + 2*margin, y1 + (2*margin), "Player Level: " + string(global.player.level));
draw_text(x1 + 2*margin, y1 + (6*margin), "HP : " + string(global.player.dynamic_hp) + " / " + string(global.player.static_hp));
draw_text(x1 + 2*margin, y1 + (8*margin), "Battery Max Time : " + string(round(global.player.dynamic_battery*10)/10) + " seconds");
draw_text(x1 + 2*margin, y1 + (10*margin), "Enemies Defeated : " + string(array_length(global.player.enemies_defeated) + array_length(global.player.bosses_defeated)));
draw_text(x1 + 2*margin, y1 + (12*margin), "Shadows Defeated : " + string(array_length(global.player.shadows_defeated)));
draw_text(x1 + 2*margin, y1 + (14*margin), "Time Alive : " + string(global.player.time_counter) + " seconds."); //TODO: convert to readable time seconds -> hours + min + sec

#endregion