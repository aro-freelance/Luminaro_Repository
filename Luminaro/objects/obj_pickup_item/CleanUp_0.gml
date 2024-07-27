/// @description tell player to display message



if(type == E_PICKUP_TYPES.HEALTH) {
	var s = "Health + " + string(amount) + " !!!";
	var c = c_red;
	
	global.player.display_message_timer = 0;
	global.player.display_message = s;
	global.player.display_message_color = c;
	global.player.display_message_on = true;
	
}
else if(type == E_PICKUP_TYPES.XP){
	var s = "XP + " + string(amount) + " !!!"; 
	var c = c_yellow;
	
	
	global.player.display_message_timer = 0;
	global.player.display_message = s;
	global.player.display_message_color = c;
	global.player.display_message_on = true;
}
else if(type == E_PICKUP_TYPES.INVENTORY){
	var item_type = global.item_descriptions[inventory_item_type];
	var s = "Found a " + string(item_type) + " !!!"; 
	var c = c_green;
	

	global.player.special_display_message_timer = 0;
	global.player.special_display_message = s;
	global.player.special_display_message_color = c;
	global.player.special_display_message_on = true;
	
}


