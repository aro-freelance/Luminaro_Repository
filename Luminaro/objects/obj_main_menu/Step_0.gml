
if(global.dg_width != 99*browser_width/100 || global.dg_height != 99*browser_height/100){
	if(os_browser != browser_not_a_browser){
	var _dw = 99*browser_width/100;
	var _dh = 99*browser_height/100;
	
	display_set_gui_size(_dw, _dh);
	//window_set_size(_dw, _dh);
	camera_set_view_size(view_camera[0], _dw, _dh);
	surface_resize(application_surface, _dw, _dh);
	window_set_rectangle(0, 0, _dw, _dh);
	global.dg_width = display_get_gui_width();
	global.dg_height = display_get_gui_height();
	display_width = global.dg_width;
	display_height = global.dg_height;
}

}

if(!init){

init = true;

var start_button = instance_create_layer(display_width/2, display_height/2 - button_height/2, "UI", obj_button_room_change);
start_button.label = "Start";
start_button.destination_room = global.start_room;



var help_button = instance_create_layer(display_width/8, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
help_button.label = "Help";
help_button.text_array = [" MOVEMENT:   WASD or Arrow Keys \n JUMP:   Up Arrow or Space \n CONTROL LIGHT BEAM:   Hold left mouse button and move mouse \n NARROW BEAM:   Q or Numberpad 1 \n WIDEN BEAM: E or Numberpad 0 \n PRISM BEAM:   Hold Center Mouse Button \n CATALYST:   Right Mouse Button \n\n OPEN MENU: F1 or Esc \n\n COMBINE ITEMS:   Click on two items in inventory and click combine."];


var credits_button = instance_create_layer(display_width/2, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
credits_button.label = "Credits";
credits_button.text_array = ["Credits: \n\n For Tom, \n     Happy Birthday! Love you :) \n\n\n\n Designed and Developed by Mandy Otero (Arora Software) \n\n\n\n\n Tileset: 2d Platformer Tiles - Dungeon's End by Tajima "];

if(os_browser == browser_not_a_browser){
	var quit_button = instance_create_layer(display_width - display_width/8, display_height - display_height/12 + button_height/2, "UI", obj_quit_game_button);
	quit_button.label = "Exit Game";
}



//TODO: button for display setting options
//settings_button = instance_create_layer(display_width/2, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
//settings_button.label = "Settings";
//settings_button.text_array = ["Settings: \n hello world"];




}
