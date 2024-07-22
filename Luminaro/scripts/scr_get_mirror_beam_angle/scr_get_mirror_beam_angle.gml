
//input a light and a mirror,  use them to output an angle that will be used to set the mirror beam angle the light creates


function scr_get_mirror_beam_angle(beam, mirror){
	
	var output_angle = 0;
	
	var beam_to_mirror_direction = point_direction(beam.x, beam.y, mirror.x, mirror.y);
	
	
	//beam is to the RIGHT of mirror center
	if(beam.image_angle > beam_to_mirror_direction){
		
		output_angle = (beam.image_angle * -1)+ 180;
		
		
		//show_debug_message("scr get mirror beam angle: RIGHT. " + string(output_angle));
	}
	//beam is to the LEFT of mirror center
	else{
		
		output_angle = (beam.image_angle * -1);
		
		
		//show_debug_message("scr get mirror beam angle: LEFT. " + string(output_angle));
	}
	
	return output_angle;

}