/*
if (browser_width != width || browser_height != height)
{
width = browser_width-5;
height = browser_height-5;
window_set_size(width, height);
}
*/



spawn_point = [display_get_gui_width()/2, display_get_gui_height()/2];	


if(global.player == noone) global.player = instance_create_layer(array_get(spawn_point, 0), array_get(spawn_point, 1), "Actors", obj_player);
//TODO: set saved stats to player

global.lighting_effects = instance_create_layer(0, 0, "Effects", obj_lighting_effects);


obj_intro_story = instance_create_layer(display_get_gui_width()/2, display_get_gui_height()/2, "UI", obj_message);
obj_intro_story.is_fullscreen = true;

//Build Story
array_push(obj_intro_story.text_array, "Level 2 Story");
array_push(obj_intro_story.text_array, "First line, of the story is here the first line");
array_push(obj_intro_story.text_array, "Second line, of the story is here the second... line");
array_push(obj_intro_story.text_array, "Third line, of the story is here the third line... ");
array_push(obj_intro_story.text_array, "Fourth line, of the story is here the fourth line... this is the long line that is so long.  Here is the story. It is long. It is a very long story. And it is still going. Are you still here? I am still here talking about the story.");


