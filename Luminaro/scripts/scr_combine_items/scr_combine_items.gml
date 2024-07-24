//combine the two input items into a new item

function scr_combine_items(input_item_1, input_item_2){

	var output_item = -1;
	var inventory = global.player.inventory;
	
	
	//TODO: set output_item to an E_INVENTORY_ITEM_TYPES using some sort of logic
	#region Set Output Item
	if( (input_item_1 == E_INVENTORY_ITEM_TYPES.TYPE_0 && input_item_2 == E_INVENTORY_ITEM_TYPES.TYPE_1) ||
		(input_item_2 == E_INVENTORY_ITEM_TYPES.TYPE_0 && input_item_1 == E_INVENTORY_ITEM_TYPES.TYPE_1) ){
		output_item = E_INVENTORY_ITEM_TYPES.TYPE_2;
	}
	
	#endregion
	
	#region Update Player Inventory
	
	if(output_item != -1){	
		array_delete(inventory, array_get_index(inventory, input_item_1), 1);
		array_delete(inventory, array_get_index(inventory, input_item_2), 1);
	
		array_push(inventory, output_item);

		show_debug_message("scr combine items");
	}
	else{
		show_message("Cannot combine those items.");
	}
	
	#endregion
	
	#region reset player menu 
	
	global.player_menu.selected_item_type_1 = -1;
	global.player_menu.selected_item_type_2 = -1;
	global.player_menu.init = false;
	
	#endregion


}