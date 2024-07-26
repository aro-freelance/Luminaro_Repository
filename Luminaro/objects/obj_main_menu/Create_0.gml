/// @description This handles the main menu buttons and navigation

global.player = noone;
global.player_menu = noone;

display_width = display_get_gui_width();
display_height = display_get_gui_height();

button_width = sprite_get_width(spr_button);
button_height = sprite_get_height(spr_button);


start_button = instance_create_layer(display_width/2, display_height/2 - button_height/2, "UI", obj_button_room_change);
start_button.label = "Start";
start_button.destination_room = global.start_room;


//Handle all of the following with a main menu obj

//TODO: button for display controls and help
help_button = instance_create_layer(display_width/4, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
help_button.label = "Help";
help_button.text_array = [" MOVEMENT:   Left Arrow, A or Right Arrow, D \n JUMP:   Up Arrow, Space or Enter \n CROUCH / PRONE: Left Control, C.  Press to Crouch, Hold to Go Prone \n CONTROL LIGHT BEAM:   Hold left mouse button and move mouse \n NARROW BEAM:   Left Alt \n WIDEN BEAM:   Left Shift \n PRISM BEAM:   Hold Center Mouse Button \n CATALYST:   Right Mouse Button \n\n OPEN MENU: F1 \n\n COMBINE ITEMS:   Click on two items in inventory and click combine."];

//TODO: button for display credits
credits_button = instance_create_layer(3*display_width/4, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
credits_button.label = "Credits";
credits_button.text_array = ["Credits: \n\n For Tom, \n     Happy Birthday! Love you :) \n\n\n\n Designed and Developed by Mandy Otero (Arora Software) \n\n\n\n\n Tileset: 2d Platformer Tiles - Dungeon's End by Tajima \n\n Tileset and Backgrounds: Oak Woods - Environment by Brullov"];
//inventory Dark World by Kaishido

//TODO: button for display setting options
//settings_button = instance_create_layer(display_width/2, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
//settings_button.label = "Settings";
//settings_button.text_array = ["Settings: \n hello world"];





