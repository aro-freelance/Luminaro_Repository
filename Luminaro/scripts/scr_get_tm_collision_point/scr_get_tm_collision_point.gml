
//input the x and y bounds and the place_meeting obj input (object, instance, tile map ID, keywords all/other, or array containing these items)

//output the average of points that have collision as array [x, y]

//THIS IS NOT WORKING ACCURATELY REMOVE OR REWORK

function scr_get_tm_collision_point(input_x, input_y, tile_layer_name){
		
	//the [x, y] position array that will be output
	var output_array = [];
	
	var collision_list = ds_list_create();
	
	var checker = instance_create_layer(0, 0, "Utility", obj_collision_checker);
	
	var tile_map = layer_tilemap_get_id(tile_layer_name);
	
	var x1 = tilemap_get_cell_x_at_pixel(tile_map, bbox_left + (input_x - x), input_y);
    var y1 = tilemap_get_cell_y_at_pixel(tile_map, input_x, bbox_top + (input_y - y));
	var x2 = tilemap_get_cell_x_at_pixel(tile_map, bbox_right + (input_x - x), input_y);
    var y2 = tilemap_get_cell_y_at_pixel(tile_map, input_x, bbox_bottom + (input_y - y));
	
	//show_debug_message("tile map bounds: x1 = " + string(x1) + ". y1 = " + string(y1) + ". x2 = "  + string(x2) + ". y2 = " + string(y2));
	
	//loop through the x and y bounds and use checker obj to check collision. add collision x,y arrays to list
	for(var _x = x1; _x <= x2; _x++){
		for(var _y = y1; _y <= y2; _y++){
	
			//get the specific tile in the set that we are looking at
			var tile = tile_get_index(tilemap_get_at_pixel(tile_map, _x, _y));
			
			//if it exists
			if(tile){
				
				//set the checker object to that position and specific tile image
				checker.x = _x * tilemap_get_tile_width(tile_map);
				checker.y = _y * tilemap_get_tile_height(tile_map);
				checker.image_index = tile;
				
				//show_debug_message("checker x = " + string(checker.x) + ". checker y = " + string(checker.y) + ". x = "+ string(_x) + ". y = " + string(_y));
				
				//if there is a collision, add the position
				if(place_meeting(input_x, input_y, checker)){
					//show_debug_message("checker x = " + string(checker.x) + ". checker y = " + string(checker.y) + ". inputx = "+ string(input_x) + ". inputy = " + string(input_y));
				
					ds_list_add(collision_list, [checker.x, checker.y]);
				}
			
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
	
	//show_debug_message("scr tm collision: output array = " + string(output_array));
	
	return output_array;

}