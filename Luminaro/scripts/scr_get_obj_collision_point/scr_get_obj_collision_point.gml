
//input the x and y bounds and the place_meeting obj input (object, instance, tile map ID, keywords all/other, or array containing these items)

//output the average of points that have collision

function scr_get_obj_collision_point(input_x, input_y, obj){
		
	//the [x, y] position array that will be output
	var output_array = [];
	
	var collision_list = ds_list_create();
	
	var checker = instance_create_layer(0, 0, "Utility", obj_collision_checker);
	
	var sprite_x_offset = sprite_get_width(obj.sprite_index) / 2;
	var sprite_y_offset = sprite_get_height(obj.sprite_index) / 2;
	
	show_debug_message("obj bounds: x1 = " + string(obj.bbox_left) + ". y1 = " + string(obj.bbox_top) + ". x2 = "  + string(obj.bbox_right) + ". y2 = " + string(obj.bbox_bottom));
	
	
	//loop through the x and y bounds and use checker obj to check collision. add collision x,y arrays to list
	for(var _x = obj.bbox_left; _x <= obj.bbox_right; _x++){
		for(var _y = obj.bbox_top; _y <= obj.bbox_bottom; _y++){
			//set the checker object to that position and specific tile image
			checker.x = _x;
			checker.y = _y;
			checker.image_index = obj.image_index;
				
				//show_debug_message("checker x = " + string(checker.x) + ". checker y = " + string(checker.y) + ". x = "+ string(_x) + ". y = " + string(_y));
				
				//if there is a collision, add the position
				if(instance_position(input_x, input_y, checker)){
					//show_debug_message("checker x = " + string(checker.x) + ". checker y = " + string(checker.y) + ". inputx = "+ string(input_x) + ". inputy = " + string(input_y));
				
					ds_list_add(collision_list, [checker.x , checker.y]);
				}
			
		}
	}
	
	//checker no longer needed
	instance_destroy(checker);
	
	
	//average the points in the list
	if(ds_list_size(collision_list) > 1){
		
		//show_debug_message("============ A");
		
		var total_x = 0;
		var total_y = 0;
		var safety = 0;
		var size = ds_list_size(collision_list);
		
		while(ds_list_size(collision_list) > 0 && safety < 200){
			safety++;
			
			var point = collision_list[| 0];
			
			//show_debug_message("collision list x = " + string(array_get(point, 0)) + ". y = " + string(array_get(point, 1)));
			
			total_x += array_get(point, 0);
			total_y += array_get(point, 1);
			ds_list_delete(collision_list, 0);
			
			
	
		}
		
		var x_average = total_x / size;
		var y_average = total_y / size;
		
		output_array = [x_average, y_average];
		
	}
	else if(ds_list_size(collision_list) == 1){
		//show_debug_message("============ B");
		output_array = collision_list[| 0];
	}
	
	ds_list_destroy(collision_list);
	
	show_debug_message("scr obj collision: output array = " + string(output_array));
	
	return output_array;

}