
if(global.game_state == E_GAME_STATE.PLAYING){


if(beam != noone){
	//if not in contact with player beam
	if(!place_meeting(x, y, global.player.beam)){
		beam.is_on = false;
		instance_destroy(beam);
		beam = noone;
	}	
	
}
	

if(beam != noone){
	beam.image_angle = global.player.beam.image_angle - 90;
	beam.sprite_rotation = beam.image_angle;
	
	if(!beam.is_on) beam.is_on = true;
}




}