/// @description Handle buttons and display on the end game screen

instance_activate_all();

main_menu_button = instance_create_layer(display_get_gui_width()/2 - sprite_get_width(spr_button)/2, display_get_gui_height()/2 - sprite_get_height(spr_button)/2, "Instances", obj_button_room_change);
main_menu_button.destination_room = rm_main_menu;


//Handle showing end game stats and messages with an end game obj