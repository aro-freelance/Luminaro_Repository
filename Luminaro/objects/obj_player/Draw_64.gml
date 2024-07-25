
//display pop up message above player
if(display_message_on){
	
	draw_set_font(fnt_display_message);
	draw_set_color(display_message_color);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_text(x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]) + display_message_offset_y, display_message)
}


if(special_display_message_on){
	
	draw_set_font(fnt_display_message);
	draw_set_color(special_display_message_color);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_text(x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]) + special_display_message_offset_y, special_display_message)
}
