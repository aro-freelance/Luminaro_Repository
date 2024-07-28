/// @description Handle buttons and display on the end game screen

instance_activate_all();

init = false;

display_width = global.dg_width;
display_height = global.dg_height;


button_width = sprite_get_width(spr_button);
button_height = sprite_get_height(spr_button);

text_area_width = 2*display_width/3;
text_area_height = 2*display_height/3;

x1 = display_width/6;
x2 = x1 + text_area_width;
y1 = display_height/6;
y2 = y1 + text_area_height;

margin = 20;
combine_text_spacing = 10;
sep = 40;



