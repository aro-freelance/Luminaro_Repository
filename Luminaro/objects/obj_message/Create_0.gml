/// @description display a message to the player

init = false;

is_fullscreen = false;

text_array = [];
ta_counter = 0;

x_scale = 1;
y_scale = 1;
alpha = 1;

background_sprite = spr_message_background_1;
background_width = sprite_get_width(background_sprite);
background_height = sprite_get_height(background_sprite);

display_width = display_get_gui_width();
display_height = display_get_gui_height();

sep = 40;
margin = 20;

text_color = c_black;

//TODO: need more logic to handle larger sizes and different alignments. spacing and start position need to be updated based on these values
text_halign = fa_left;
text_valign = fa_top;
text_font = fnt_story_box;

is_transition = false;
transition_room = rm_main_menu;