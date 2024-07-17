/*
if (browser_width != width || browser_height != height)
{
width = browser_width-5;
height = browser_height-5;
window_set_size(width, height);
}
*/

spawn_point = [display_get_gui_width()/2, display_get_gui_height()/2];	

global.player = instance_create_layer(array_get(spawn_point, 0), array_get(spawn_point, 1), "Instances", obj_player);
