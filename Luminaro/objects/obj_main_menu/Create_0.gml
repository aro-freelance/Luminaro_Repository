/// @description This handles the main menu buttons and navigation

global.player = noone;
global.player_menu = noone;

start_button = instance_create_layer(display_get_gui_width()/2 - sprite_get_width(spr_button)/2, display_get_gui_height()/2 - sprite_get_height(spr_button)/2, "Instances", obj_button_room_change);
start_button.destination_room = rm_level1;


//Handle all of the following with a main menu obj

//TODO: button for display controls and help


//TODO: button for display credits


//TODO: button for display setting options