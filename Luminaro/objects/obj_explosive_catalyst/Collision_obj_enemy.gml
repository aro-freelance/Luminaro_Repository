/// @description explosive catalyst collision with normal enemy


if(is_exploding){

	other.dynamic_hp = other.dynamic_hp - damage;
	
	show_debug_message("catalyst / enemy collision. enemy hp = " + string(other.dynamic_hp));

}