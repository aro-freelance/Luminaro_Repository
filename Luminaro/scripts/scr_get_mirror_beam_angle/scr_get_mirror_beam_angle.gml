
//input a light and a mirror,  use them to output an angle that will be used to set the mirror beam angle the light creates


function scr_get_mirror_beam_angle(beam, mirror){
	
	
	var output_angle = 0;
	
	
	if(variable_global_exists("player")){
		if(global.player != noone){
	
			var beam_to_mirror_direction = point_direction(beam.x, beam.y, mirror.x, mirror.y);
	
			//player facing right
			if(global.player.facing == E_FACING.right){
		
				//beam is to the RIGHT of mirror center
				if(beam.image_angle > beam_to_mirror_direction){
		
					output_angle = (beam.image_angle * -1)+ 180;
		
				}
				//beam is to the LEFT of mirror center
				else{
		
					output_angle = (beam.image_angle * -1);
		
				}	
			}
			//player facing left
			else{
	
				//beam is to the RIGHT of mirror center
				if(beam.image_angle > beam_to_mirror_direction){
		
					output_angle = (beam.image_angle * -1);
		
				}
				//beam is to the LEFT of mirror center
				else{
		
					output_angle = (beam.image_angle * -1)+ 180;
				}

			}
		
		
			//if it is basically a direct hit, bounce back to player rather than allowing it to go straight through
			if(abs(output_angle) > 80 && abs(output_angle) < 100) output_angle =  - abs(output_angle);
		
		}
	}
		
	
	return output_angle;

}