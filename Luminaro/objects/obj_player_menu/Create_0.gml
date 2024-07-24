/// @description In Game Menu



init = false;

state = E_PLAYER_MENU_STATE.DISPLAY_STATS;

#region Display Constants

display_center_x = display_get_gui_width()/2;
display_center_y = display_get_gui_height()/2;

menu_width = 2*display_get_gui_width()/3;
menu_height = 2*display_get_gui_height()/3;

x1 = display_get_gui_width()/6;
x2 = x1 + menu_width;
y1 = display_get_gui_height()/6;
y2 = y1 + menu_height;

margin = 20;

button_width = sprite_get_width(spr_button);
button_height = sprite_get_height(spr_button);

combine_x = (display_center_x + sprite_get_width(spr_inventory_item) + x2 - margin) / 2;

combine_sprite_scale = 1.65;

combine_text_spacing = 10;
sep = 40;

#endregion


//store the results of a level up
level_up_results = [];


//selected items for combine
selected_item_type_1 = -1;
selected_item_type_2 = -1;



