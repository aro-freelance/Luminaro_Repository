/// @description pickup inventory item (an item that will be placed in player inventory)


// Inherit the parent event
event_inherited();



type = E_PICKUP_TYPES.INVENTORY;

amount = 1;

should_move_to_player = true;

move_to_player_speed = 5;

inventory_item_type = E_INVENTORY_ITEM_TYPES.TYPE_1;

