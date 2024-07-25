
//transition the player to the next room

function scr_level_transition(destination_room){

//there are no more levels
if(destination_room >= E_LEVELS.last){
	show_debug_message("scr level transition: End of levels. TODO: setup functionality for winning the game here. ");
	//TODO: for the jam display a message saying that is the end of the jam demo and return player to main menu... 
}
else{
	
	show_debug_message("scr level transition: End of level. moving to next");
	//TODO: display end of level message when it closes move the player to the next room.
	
	//make child class for message that transitions to next room on dstroy?
	
}

}