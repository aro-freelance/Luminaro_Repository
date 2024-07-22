// set the mirror beam angle based on the angle difference with the holder (the beam that created it)




function scr_get_hit_mirror(beam){

	
	var mirror_distance_list = ds_list_create();
	
	//top left
	if(bbox_left < holder.bbox_left && bbox_bottom < holder.bbox_bottom){
		//show_debug_message("top left");
		var point = [bbox_left, bbox_top];
	}
	//top right
	else if(bbox_right > holder.bbox_right && bbox_bottom < holder.bbox_bottom){
		//show_debug_message("top right");
		var point = [bbox_right , bbox_top];
	}
	//bottom left
	else if(bbox_left < holder.bbox_left && bbox_top > holder.bbox_top){
		//show_debug_message("bottom left");
		var point = [bbox_left , bbox_bottom];
	}
	//bottom right
	else if(bbox_right > holder.bbox_right && bbox_top > holder.bbox_top){
		//show_debug_message("bottom right");
		var point = [bbox_right , bbox_bottom];
	}
	else{
		var point = [];
	}
	
	
	if(array_length(point) == 2){
		with(obj_mirror){
		
			var d = distance_to_point(array_get(point, 0), array_get(point, 1));
	
			ds_list_add(mirror_distance_list, [obj_mirror, d]);
		
		}
	
		var lowest_d = -1;
		var selected_mirror = noone;
		for(i = 0; i < ds_list_size(mirror_distance_list); i++){
	
			var mirror_array = mirror_distance_list[| i];
	
			var d = array_get(mirror_array, 1);
		
			if(lowest_d == -1 || d < lowest_d){
				lowest_d = d;
				selected_mirror = array_get(mirror_array, 0);
			}
		
		}
		
		//show_debug_message("scr get mirror: selected_mirror = " + string(selected_mirror));
		
		
		return selected_mirror;
		
	}
	else{
		
		//show_debug_message("scr get mirror: return noone");
		
		return noone;
	}
	

}
