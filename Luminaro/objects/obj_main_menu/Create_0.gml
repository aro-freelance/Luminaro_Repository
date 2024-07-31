/// @description This handles the main menu buttons and navigation

global.player = noone;
global.player_menu = noone;

display_width = global.dg_width;
display_height = global.dg_height;

button_width = sprite_get_width(spr_button);
button_height = sprite_get_height(spr_button);

init = false;

margin = 20;

start_button = instance_create_layer(display_width/2, 2*display_height/3 - button_height/2, "UI", obj_button_room_change);
start_button.label = "Start";
start_button.destination_room = global.start_room;



help_button = instance_create_layer(display_width/8, display_height - display_height/12 - button_height/2 - margin, "UI", obj_display_text_button);
help_button.label = "Help";
help_button.text_array = [" MOVEMENT:   WASD or Arrow Keys \n\n CONTROL LIGHT BEAM:   Hold left mouse button and move mouse \n\n NARROW BEAM:   Q or Numberpad 1 (Toggle) \n\n WIDEN BEAM: E or Numberpad 0 (Toggle) \n\n PRISM BEAM:   Hold Center Mouse Button \n\n CATALYST:   Right Mouse Button \n\n OPEN MENU: F1 or Esc \n\n COMBINE ITEMS:   Click on two items in inventory and click combine."];


credits_button = instance_create_layer(display_width/8, display_height - display_height/12 + button_height/2, "UI", obj_display_text_button);
credits_button.label = "Credits";
credits_button.text_array = ["Credits: \n\n Designed and Developed by Mandy Otero (Arora Software)  \n\n Playtesting by Neale Reimers \n\n Tileset: '2D Platformer Tiles - Dungeon's End' by Tajima \n\n For Tom, Happy Birthday! Love you :) "];

if(os_browser == browser_not_a_browser){
	quit_button = instance_create_layer(display_width - display_width/8, display_height - display_height/12 + button_height/2, "UI", obj_quit_game_button);
	quit_button.label = "Exit Game";
}
else quit_button = noone;






