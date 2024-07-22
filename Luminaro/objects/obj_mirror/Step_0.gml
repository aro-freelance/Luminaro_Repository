
if(global.game_state == E_GAME_STATE.PLAYING){



#region End Beam
if(beam != noone){
	if(beam.is_on){
		if(beam.holder != noone){
			if(array_length(scr_get_obj_collision_point(beam.x, beam.y, beam.holder)) != 2){
				beam.holder.bounce_counter = clamp(beam.holder.bounce_counter-1, 0, beam.holder.bounce_number);
				show_debug_message("destroy mirror beam " + string(beam) + ". holder bounce number = " + string(beam.holder.bounce_counter));
				beam.is_on = false;
			}
			else if (!global.player.beam.is_on && (ds_list_size(global.player.prism_beams) < 1)){
				beam.holder = 0;
				show_debug_message("destroy mirror beam " + string(beam) + ". holder bounce number = " + string(beam.holder.bounce_counter));
				beam.is_on = false;
			}
		}
	}
	
}
#endregion






}