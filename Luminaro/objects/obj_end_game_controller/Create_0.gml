/// @description Handle buttons and display on the end game screen

instance_activate_all();

display_width = display_get_gui_width();
display_height = display_get_gui_height();


button_width = sprite_get_width(spr_button);
button_height = sprite_get_height(spr_button);

text_area_width = 2*display_get_gui_width()/3;
text_area_height = 2*display_get_gui_height()/3;

x1 = display_get_gui_width()/6;
x2 = x1 + text_area_width;
y1 = display_get_gui_height()/6;
y2 = y1 + text_area_height;

margin = 20;
combine_text_spacing = 10;
sep = 40;



main_menu_button = instance_create_layer(display_width/2, display_height - display_height/12, "Instances", obj_button_room_change);
main_menu_button.label = "Main Menu";
main_menu_button.destination_room = rm_main_menu;


