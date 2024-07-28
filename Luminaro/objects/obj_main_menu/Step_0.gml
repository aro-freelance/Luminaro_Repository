
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


//Handle all of the following with a main menu obj

//TODO: button for display controls and help
var help_button = instance_create_layer(display_width/4, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
help_button.label = "Help";
help_button.text_array = [" MOVEMENT:   Left Arrow, A or Right Arrow, D \n JUMP:   Up Arrow, Space or Enter \n CROUCH / PRONE: Left Control, C.  Press to Crouch, Hold to Go Prone \n CONTROL LIGHT BEAM:   Hold left mouse button and move mouse \n NARROW BEAM:   Left Alt \n WIDEN BEAM:   Left Shift \n PRISM BEAM:   Hold Center Mouse Button \n CATALYST:   Right Mouse Button \n\n OPEN MENU: F1 \n\n COMBINE ITEMS:   Click on two items in inventory and click combine."];

//TODO: button for display credits
var credits_button = instance_create_layer(3*display_width/4, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
credits_button.label = "Credits";
credits_button.text_array = ["Credits: \n\n For Tom, \n     Happy Birthday! Love you :) \n\n\n\n Designed and Developed by Mandy Otero (Arora Software) \n\n\n\n\n Tileset: 2d Platformer Tiles - Dungeon's End by Tajima \n\n Tileset and Backgrounds: Oak Woods - Environment by Brullov"];



//TODO: button for display setting options
//settings_button = instance_create_layer(display_width/2, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
//settings_button.label = "Settings";
//settings_button.text_array = ["Settings: \n hello world"];




}
