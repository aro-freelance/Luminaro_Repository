
draw_sprite_ext(background_sprite, 0, x - background_width/2, y - background_height/2, x_scale, y_scale, 0, c_white, alpha);


draw_set_font(text_font);
draw_set_color(text_color);
draw_set_valign(text_valign);
draw_set_halign(text_halign);

if(array_length(text_array) >= ta_counter && array_length(text_array) > 0){
	draw_text_ext(x - background_width/2 + margin, y - background_height/2 + margin, array_get(text_array, ta_counter), sep, background_width - (2*margin));
}