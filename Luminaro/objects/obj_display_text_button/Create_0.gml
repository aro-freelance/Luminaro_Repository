/// @description when this is clicked build an obj_message


depth = -50;

display_width = display_get_gui_width();
display_height = display_get_gui_height();

//label to show on button
label = "";

#region Build Message

is_fullscreen = false;

text_array = [];

x_scale = 1;
y_scale = 1;
alpha = 1;

background_sprite = spr_message_background_1;

text_color = c_black;
text_halign = fa_left;
text_valign = fa_top;
text_font = fnt_story_box;

#endregion
