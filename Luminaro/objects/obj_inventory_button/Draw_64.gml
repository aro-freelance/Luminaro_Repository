

draw_sprite(spr_inventory_item, item_type, x, y);



if(tooltip_on){

	var x1 = device_mouse_x_to_gui(0);
	var y1 = device_mouse_y_to_gui(0);
	var back_color = c_white;
	var s = global.item_descriptions[item_type];
	
	tooltip_box_width = string_width(s) *1.2;
	
	
	
	draw_rectangle_color(x1, y1, x1 + tooltip_box_width, y1 + tooltip_box_height, back_color, back_color, back_color, back_color, false);
	
	
	draw_set_font(fnt_display_message);
	draw_set_color(c_black);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	draw_text((x1 * 2 + tooltip_box_width)/2, (y1 * 2 + tooltip_box_height)/2, s);
	
}